require './gemas'
require 'sinatra'

get '/' do
  erb :"index"
end

get '/lista_empleados'do
  @empleados = RepositorioEmpleado.instance.recuperarEmpleados
  erb :"empleados/lista_empleados"
end

get '/nuevo_empleado' do
  @empleado = RepositorioEmpleado.instance.instanciarNuevo
  @ya_fue_creado = RepositorioSindicato.instance.ya_fue_creado?
  erb :"empleados/nuevo_empleado"
end

post '/empleados' do
  empleado = Empleado.crearEmpleado(params[:ci],params[:nombre],params[:apellido],params[:fecha],
                                    params[:tiene_sindicato],params[:tipo_contrato],
                                    params[:tipo_salario],params[:salario])
  RepositorioEmpleado.instance.guardar(empleado)
  @empleados = RepositorioEmpleado.instance.recuperarEmpleados
  erb :"empleados/lista_empleados"
end

get "/ver_empleado/:ci" do
  @empleado = RepositorioEmpleado.instance.recuperarPorCI(params[:ci])  
  @ya_fue_creado = RepositorioSindicato.instance.ya_fue_creado?
  erb :"empleados/ver_empleado"
end

get "/modificar_empleado/:ci" do
  @empleado = RepositorioEmpleado.instance.recuperarPorCI(params[:ci])
  @ya_fue_creado = RepositorioSindicato.instance.ya_fue_creado?
  erb :"empleados/modificar_empleado"
end

put "/modificar_empleados" do
  empleado = Empleado.crearEmpleado(params[:ci],params[:nombre],params[:apellido],params[:fecha],
                                    params[:tiene_sindicato],params[:tipo_contrato],
                                    params[:tipo_salario],params[:salario])
  RepositorioEmpleado.instance.actualizar(empleado)
  @empleados = RepositorioEmpleado.instance.recuperarEmpleados
  erb :"empleados/lista_empleados"
end

get "/eliminar_empleado/:ci" do
  RepositorioEmpleado.instance.eliminarPorCI(params[:ci])
  @empleados = RepositorioEmpleado.instance.recuperarEmpleados
  erb :"empleados/lista_empleados"
end

get "/agregar_tarjeta_tiempo/:ci" do
  @tarjetaTiempo = TarjetaDeTiempo.new(Date.today, params[:ci], Time.now,Time.now)  
  erb :"empleados/agregar_tarjeta_tiempo"
end

post "/guardar_tarjeta_tiempo" do
  tarjeta_tiempo = TarjetaDeTiempo.crear_tarjeta(params[:fecha], params[:ci], params[:ingreso], params[:salida])
  RepositorioEmpleado.instance.guardarTarjetaDeTiempoParaUnEmpleado(tarjeta_tiempo, params[:ci])
  @empleados = RepositorioEmpleado.instance.recuperarEmpleados
  erb :"empleados/lista_empleados"
end

get "/cheques" do
  empleados =  RepositorioEmpleado.instance.recuperarEmpleados
  sindicato = RepositorioSindicato.instance.retornar_sindicato
  @cheques = RepositorioCheques.instance.generarChequesDe(empleados,sindicato)
  erb :"cheques/lista_cheques" 
end

get "/sindicato" do
  if RepositorioSindicato.instance.ya_fue_creado?
    @hay_empleados_con_sindicato = RepositorioEmpleado.instance.hayEmpleadosConSindicato?
    @sindicato = RepositorioSindicato.instance.retornar_sindicato
    erb :"sindicato/ver_sindicato"
  else
    @date = Date.today
    erb :"sindicato/nuevo_sindicato"
  end
end

post "/nuevo_sindicato" do
  @hay_empleados_con_sindicato = RepositorioEmpleado.instance.hayEmpleadosConSindicato?
  @sindicato = Sindicato.crear_sindicato(params[:nombre], params[:fecha], params[:descuento])
  RepositorioSindicato.instance.crear(@sindicato)
  erb :"sindicato/ver_sindicato"
end

get "/modificar_sindicato" do
  @sindicato = RepositorioSindicato.instance.retornar_sindicato()
  erb :"sindicato/modificar_sindicato"
end

put "/guardar_sindicato"do 
  @hay_empleados_con_sindicato = RepositorioEmpleado.instance.hayEmpleadosConSindicato?
  sindicato = Sindicato.crear_sindicato(params[:nombre],params[:fecha],params[:descuento])
  RepositorioSindicato.instance.modificar(sindicato)
  @sindicato = RepositorioSindicato.instance.retornar_sindicato
  erb :"sindicato/ver_sindicato"  
end

get "/tarjeta_servicio" do
  @date = Date.today
  @empleados = RepositorioEmpleado.instance.recuperarEmpleadosConSindicato
  erb :"sindicato/tarjetas_servicio/nueva_tarjeta_servicio"
end

post "/nueva_tarjeta_servicio" do
  @hay_empleados_con_sindicato = RepositorioEmpleado.instance.hayEmpleadosConSindicato?
  tarjeta_servicio = TarjetaDeServicio.crear_tarjeta_servicio(params[:fecha], params[:ci_empleado], 
                                                              params[:monto], params[:descripcion])
  RepositorioSindicato.instance.agregar_tarjeta_servicio(tarjeta_servicio)  
  @sindicato = RepositorioSindicato.instance.retornar_sindicato
  erb :"sindicato/ver_sindicato"
end

get "/modificar_tarjeta_servicio/:object_id" do
  @date = Date.today
  @empleados = RepositorioEmpleado.instance.recuperarEmpleadosConSindicato
  @object_id = params[:object_id]
  @tarjeta_servicio = RepositorioSindicato.instance.recuperar_tarjeta_servicio_por(@object_id)
  erb :"sindicato/tarjetas_servicio/modificar_tarjeta_servicio"
end

put "/modificar_tarjetas_servicios" do
  @hay_empleados_con_sindicato = RepositorioEmpleado.instance.hayEmpleadosConSindicato?
  tarjeta_servicio = TarjetaDeServicio.crear_tarjeta_servicio(params[:fecha], params[:ci_empleado], 
                                                              params[:monto], params[:descripcion])
  RepositorioSindicato.instance.modificar_tarjeta_servicio(tarjeta_servicio, params[:object_id])  
  @sindicato = RepositorioSindicato.instance.retornar_sindicato
  erb :"sindicato/ver_sindicato"
end

get "/eliminar_tarjeta_servicio/:object_id" do
  @hay_empleados_con_sindicato = RepositorioEmpleado.instance.hayEmpleadosConSindicato?
  RepositorioSindicato.instance.eliminar_tarjeta_servicio_por(params[:object_id])  
  @sindicato = RepositorioSindicato.instance.retornar_sindicato
  erb :"sindicato/ver_sindicato"
end
get "/memoria" do
  RepositorioEmpleado.instance.cambiarPersistencia("memoria")
  RepositorioSindicato.instance.cambiarPersistencia("memoria")
  erb :"index"
end
get "/json" do
  RepositorioEmpleado.instance.cambiarPersistencia("json")
  RepositorioSindicato.instance.cambiarPersistencia("json")
  erb :"index"
end














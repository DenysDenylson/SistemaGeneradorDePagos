require './gemas'
require 'sinatra'

get '/' do
  @empleados = RepositorioEmpleado.instance.recuperarEmpleados
  erb :"empleados/lista_empleados"
end

get '/nuevo_empleado' do
  @empleado = RepositorioEmpleado.instance.instanciarNuevo
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
  erb :"empleados/ver_empleado"
end

get "/modificar_empleado/:ci" do
  @empleado = RepositorioEmpleado.instance.recuperarPorCI(params[:ci])
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
  if RepositorioSindicato.instance.existe?
    @date = Date.today
    erb :"sindicato/nuevo_sindicato"
  else
     @sindicato = RepositorioSindicato.instance.retornar_sindicato
    erb :"sindicato/ver_sindicato"
  end
end

post "/nuevo_sindicato" do
  @sindicato = Sindicato.crear_sindicato(params[:nombre], params[:fecha], params[:descuento])
  RepositorioSindicato.instance.crear(@sindicato)
  erb :"sindicato/ver_sindicato"
end











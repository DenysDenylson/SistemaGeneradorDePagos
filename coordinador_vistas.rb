require './gemas'
require 'sinatra'

get '/' do
  @empleados = RepositorioEmpleado.instance.recuperarEmpleados
  erb :"empleados/lista_empleados"
end

get '/nuevo_empleado' do
  @empleado = RepositorioEmpleado.instance.instanciarNuevoEmpleado
  erb :"empleados/nuevo_empleado"
end

post '/empleados' do
  empleado = Empleado.crearEmpleado(params[:ci],params[:nombre],params[:apellido],
                                    params[:fecha],params[:tipo_contrato],
                                    params[:tipo_salario],params[:salario])
  RepositorioEmpleado.instance.guardarEmpleado(empleado)
  @empleados = RepositorioEmpleado.instance.recuperarEmpleados
  erb :"empleados/lista_empleados"
end

get "/ver_empleado/:ci" do
  @empleado = RepositorioEmpleado.instance.recuperarEmpleadoPorCI(params[:ci])
  erb :"empleados/ver_empleado"
end

get "/modificar_empleado/:ci" do
  @empleado = RepositorioEmpleado.instance.recuperarEmpleadoPorCI(params[:ci])
  erb :"empleados/modificar_empleado"
end

put "/empleados/:ci" do
  empleado = Empleado.crearEmpleado(params[:ci],params[:nombre],params[:apellido],
                                    params[:fecha],params[:tipo_contrato],
                                    params[:tipo_salario],params[:salario])
  
  RepositorioEmpleado.instance.actualizarEmpleados(empleado)
  @empleados = RepositorioEmpleado.instance.recuperarEmpleados
  erb :"empleados/lista_empleados"
end

get "/eliminar_empleado/:ci" do
  RepositorioEmpleado.instance.eliminarEmpleadoPorCI(params[:ci])
  @empleados = RepositorioEmpleado.instance.recuperarEmpleados
  erb :"empleados/lista_empleados"
end

get "/agregar_tarjeta_tiempo/:ci" do
  @tarjetaTiempo = TarjetaDeTiempo.new(Date.today, params[:ci], Time.now,Time.now)  
  erb :"empleados/agregar_tarjeta_tiempo"
end

post "/tarjeta_tiempo/:ci" do
  tarjetaTiempo = TarjetaDeTiempo.crear_tarjeta(params[:ci], params[:fecha], params[:ingreso], params[:egreso])
  RepositorioEmpleado.instance.guardarTarjetaDeTiempoParaUnEmpleado(tarjetaTiempo, params[:ci])
  @empleados = RepositorioEmpleado.instance.recuperarEmpleados
  erb :"empleados/lista_empleados"
end

get "/cheques" do
  @empleados =  RepositorioEmpleado.instance.recuperarEmpleados
  @cheques = RepositorioCheques.instance.generarChequesDe(@empleados)
  erb :"cheques/lista_cheques"
end











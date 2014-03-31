require './gemas'
require 'sinatra'

get '/' do
  @empleados = Persistencia.instance.recuperarEmpleados
  erb :"empleados/lista_empleados"
end

get '/nuevo_empleado' do
  @empleado = Persistencia.instance.instanciarNuevoEmpleado
  erb :"empleados/nuevo_empleado"
end

post '/empleados' do
  empleado = Empleado.crearEmpleado(params[:ci],params[:nombre],params[:apellido],
                                    params[:fecha_inicio_contrato],params[:tipo_contrato],
                                    params[:tipo_salario],params[:salario])
  Persistencia.instance.guardarEmpleado(empleado)
  @empleados = Persistencia.instance.recuperarEmpleados
  erb :"empleados/lista_empleados"
end

get "/ver_empleado/:ci" do
  @empleado = Persistencia.instance.recuperarEmpleadoPorCI(params[:ci])
  erb :"empleados/ver_empleado"
end

get "/modificar_empleado/:ci" do
  @empleado = Persistencia.instance.recuperarEmpleadoPorCI(params[:ci])
  erb :"empleados/modificar_empleado"
end

put "/empleados/:ci" do
  empleado = Empleado.crearEmpleado(params[:ci],params[:nombre],params[:apellido],
                                    params[:fecha_inicio_contrato],params[:tipo_contrato],
                                    params[:tipo_salario],params[:salario])
  
  Persistencia.instance.actualizarEmpleados(empleado)
  @empleados = Persistencia.instance.recuperarEmpleados
  erb :"empleados/lista_empleados"
end

get "/eliminar_empleado/:ci" do
  Persistencia.instance.eliminarEmpleadoPorCI(params[:ci])
  @empleados = Persistencia.instance.recuperarEmpleados
  erb :"empleados/lista_empleados"
end











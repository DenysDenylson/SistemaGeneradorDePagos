require './gemas'
require 'sinatra'

get '/' do
  @empleados = Persistencia.instance.recuperarEmpleados
  erb :"empleados/lista_empleados"
end

get '/nuevo_empleado' do
	@empleado = Empleado.new('', '', '', Date.today, ContratoMensual.new)
  erb :"empleados/nuevo_empleado"
end

get "/modificar_empleado/:id" do
  
  erb :"empleados/nuevo_empleado"
end

put "/modificar_empleado" do
  
  erb :"empleados/lista_empleados"
end

get "/eliminar_empleado/:ci" do
  Persistencia.instance.eliminarEmpleadoPorCI(params[:ci])
  @empleados = Persistencia.instance.recuperarEmpleados
  erb :"empleados/lista_empleados"
end

post '/empleados' do
  ci = params[:ci]
  nombre = params[:nombre]
  apellido = params[:apellido]
  fecha_inicio_contrato = params[:fecha_inicio_contrato]
  
  if params[:tipo_contrato] == "true"
    tipo_contrato = ContratoQuincenal.new
  else
    tipo_contrato = ContratoMensual.new
  end
  
  Persistencia.instance.cargarEmpleado(Empleado.new(ci, nombre, apellido, fecha_inicio_contrato, tipo_contrato))
  @empleados = Persistencia.instance.recuperarEmpleados
  erb :"empleados/lista_empleados"
end









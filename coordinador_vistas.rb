require './gemas'
require 'sinatra'
require 'json'

get '/' do
  @empleados = Persistencia.instance.recuperarEmpleados
  erb :"empleados/lista_empleados"
end

get '/empleados/nuevo_empleado' do
	@empleado = Empleado.new('', '', '', Date.today, ContratoMensual.new)
erb :"empleados/nuevo_empleado"
end

post '/empleados' do
#  empleado = params[:empleado]
  ci = 12312
  nombre = params[:nombre]
  apellido = 'empleado.apellido'

  Persistencia.instance.cargarEmpleado(Empleado.new(ci.to_s, nombre.to_s, apellido.to_s, Date.new(2012,1,1), ContratoMensual.new))
  
  @empleados = Persistencia.instance.recuperarEmpleados
  
  erb :"empleados/lista_empleados"
end
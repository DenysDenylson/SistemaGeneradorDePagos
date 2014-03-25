require './gemas'
require 'sinatra'

get '/' do
  @empleados = Persistencia.instance.recuperarEmpleados
  erb :"empleados/lista_empleados"
end

get '/nuevo_empleado' do
	@empleado = Empleado.new('', '', '', Date.today, ContratoMensual.new)
	@empleado.clasificador_salario = ClasificadorSalarioFijo.new(0,Date.today)
  erb :"empleados/nuevo_empleado"
end

post '/empleados' do
  ci = params[:ci]
  nombre = params[:nombre]
  apellido = params[:apellido]
  fecha_inicio_contrato = params[:fecha_inicio_contrato]
  
  case params[:tipo_contrato]
  when "quincenal"
    tipo_contrato = ContratoQuincenal.new
  when "mensual"
    tipo_contrato = ContratoMensual.new
  end
  
  empleado = Empleado.new(ci, nombre, apellido, fecha_inicio_contrato, tipo_contrato)
  empleado.asignar_tipo_salario(params[:tipo_salario], params[:salario])
  
  Persistencia.instance.cargarEmpleado(empleado)
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
  ci = params[:ci]
  nombre = params[:nombre]
  apellido = params[:apellido]
  fecha_inicio_contrato = params[:fecha_inicio_contrato]
  
  case params[:tipo_contrato]
  when "quincenal"
    tipo_contrato = ContratoQuincenal.new
  when "mensual"
    tipo_contrato = ContratoMensual.new
  end
  
  empleado = Empleado.new(ci, nombre, apellido, fecha_inicio_contrato, tipo_contrato)
  empleado.asignar_tipo_salario(params[:tipo_salario], params[:salario])
  
  Persistencia.instance.actualizarEmpleados(empleado)
  @empleados = Persistencia.instance.recuperarEmpleados
  erb :"empleados/lista_empleados"
end

get "/eliminar_empleado/:ci" do
  Persistencia.instance.eliminarEmpleadoPorCI(params[:ci])
  @empleados = Persistencia.instance.recuperarEmpleados
  erb :"empleados/lista_empleados"
end











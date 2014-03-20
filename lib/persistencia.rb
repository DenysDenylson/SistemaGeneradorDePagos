require 'singleton'
require 'date'

class Persistencia 
  include Singleton
  attr_accessor :empleados
  
  def initialize
    @empleados = Array.new
    @empleados.push(Empleado.new('3343', 'Juan', 'Perez', Date.new(2012,1,1),ContratoMensual.new))
    
  end
  
  def cargarEmpleado(empleado)
    @empleados.push(empleado)
  end

  def recuperarEmpleados 
    @empleados
  end
  
end
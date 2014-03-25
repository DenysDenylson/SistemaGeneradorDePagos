require 'singleton'
require 'date'

class Persistencia 
  include Singleton
  
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

  def recuperarEmpleadoPorCI(ci) 
    empleado = @empleados.each{|x| x.ci == ci }
  end
  
  def actualizarEmpleados(empleado)
    @empleados.each{|x| if x.ci == empleado.ci 
                            x = empleado
                        end
                   }
  end
  
  def eliminarEmpleadoPorCI(ci)
    @empleados.delete_if{|x| x.ci == ci}
  end
  
  private
  def actualizarEmpleadoPorCI
  end
  
end
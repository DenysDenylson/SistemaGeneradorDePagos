require 'singleton'
require 'date'

class Persistencia 
  include Singleton
  
  def initialize
    @empleados = Array.new
  end
  
  def cargarEmpleado(empleado)
    @empleados.push(empleado)
  end
  
  def recuperarEmpleados
    @empleados
  end

  def recuperarEmpleadoPorCI(ci) 
    empleado = @empleados.select{|x| x.ci == ci }
    empleado.first
  end
  
  def actualizarEmpleados(empleado)
    @empleados = @empleados.collect{|x| if x.ci == empleado.ci 
                                          x = empleado
                                        else 
                                          x
                                        end
                                   }
  end
  
  def eliminarEmpleadoPorCI(ci)
    @empleados.delete_if{|x| x.ci == ci}
  end
  
end
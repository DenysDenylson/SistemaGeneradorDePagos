require 'singleton'
require 'date'

class Persistencia 
  include Singleton
  
  def initialize
    @empleados = Array.new
  end
  
  def guardarEmpleado(empleado)
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
                                        end
                                   }
  end
  
  def eliminarEmpleadoPorCI(ci)
    @empleados.delete_if{|x| x.ci == ci}
  end
  
  def instanciarNuevoEmpleado
  	@empleado = Empleado.new('', '', '', Date.today, ContratoMensual.new)
  	@empleado.clasificador_salario = ClasificadorSalarioFijo.new(0,Date.today)
  	@empleado
	end
  
  
end
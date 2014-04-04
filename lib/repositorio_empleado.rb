require 'singleton'
require 'date'

class RepositorioEmpleado 
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
    empleado = @empleados.select{|e| e.ci == ci }
    empleado.first
  end
  
  def actualizarEmpleados(empleado)
    @empleados.collect!{|e| if e.ci == empleado.ci 
                              e = empleado
                            end
                       }
  end
  
  def eliminarEmpleadoPorCI(ci)
    @empleados.delete_if{|e| e.ci == ci}
  end
  
  def instanciarNuevoEmpleado
  	@empleado = Empleado.new('', '', '', Date.today, ContratoMensual.new)
  	@empleado.clasificador_salario = ClasificadorSalarioFijo.new(0,Date.today)
  	@empleado
	end
  
end
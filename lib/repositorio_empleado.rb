require 'singleton'
require 'date'

class RepositorioEmpleado 
  include Singleton
  
  def initialize
    @empleados = Array.new
    
    empleado = Empleado.crearEmpleado("123","juan", "Perez","2012-1-1","quincenal","por_hora","50")
    tarjeta_tiempo = TarjetaDeTiempo.crear_tarjeta( "2012-2-4", "123423", "8:00", "12:00")
    
    empleado.registrar_tarjeta_de_tiempo(tarjeta_tiempo)
    
    @empleados.push(empleado)
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
    @empleados = @empleados.collect{|e| if e.ci == empleado.ci 
                                          e = empleado
                                        end
                                    }
  end
  
  def eliminarEmpleadoPorCI(ci)
    @empleados.delete_if{|e| e.ci == ci}
  end
  
  def instanciarNuevoEmpleado
  	empleado = Empleado.new('', '', '', Date.new(2014,1,1), ContratoMensual.new)
  	empleado.clasificador_salario = ClasificadorSalarioFijo.new(0,Date.today)
  	empleado
	end
	
	def guardarTarjetaDeTiempoParaUnEmpleado(tarjeta_tiempo, ci)
	  @empleados = @empleados.collect{|e| if e.ci == ci 
                                          e.registrar_tarjeta_de_tiempo(tarjeta_tiempo)
                                        end
                                   }
  end
  
end











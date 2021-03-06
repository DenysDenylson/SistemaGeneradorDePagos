require 'singleton'
require 'date'

class RepositorioEmpleado 
  include Singleton
  
  def initialize
    @empleados = Array.new
    @persistencia=RepositorioPersistencia.new("./db/empleado.json")
  end
  
  def guardar(empleado)
    @empleados.push(empleado)
    @persistencia.guardar_todos(@empleados)
  end
  
  def recuperarEmpleados
    @empleados = @persistencia.recuperar_todos
  end
  
  def recuperarEmpleadosConSindicato
    @empleados = @persistencia.recuperar_todos
    empleados = []
    @empleados.each do |empleado| empleados.push(empleado) if empleado.tiene_sindicato? end
    empleados
  end
  
  def hayEmpleadosConSindicato?
    if recuperarEmpleadosConSindicato == []
      return false
    else
      return true
    end
  end

  def recuperarPorCI(ci) 
    @empleados = @persistencia.recuperar_todos
    empleado = @empleados.select{|e| e.ci == ci }
    empleado.first
  end
  
  def actualizar(empleado)
    @empleados.collect!{|e| if e.ci == empleado.ci 
                              e.modificar_atributos(empleado)
                            end
                            e
                      }
    @persistencia.guardar_todos(@empleados) 
  end
  
  def eliminarPorCI(ci)
    @empleados.delete_if{|e| e.ci == ci}
    @persistencia.guardar_todos(@empleados) 
  end
  
  def instanciarNuevo
  	empleado = Empleado.new('', '', '', Date.new(2014,1,1), ContratoMensual.new)
  	empleado.clasificador_salario = ClasificadorSalarioFijo.new(0,Date.today)
  	empleado.tiene_sindicato = false
  	empleado
	end

	def guardarTarjetaDeTiempoParaUnEmpleado(tarjeta_tiempo, ci)
	  @empleados.collect!{|e| if e.ci == ci 
                              e.registrar_tarjeta_de_tiempo(tarjeta_tiempo)
                            end
                            e
                       }
    @persistencia.guardar_todos(@empleados) 
    
  end
  def cambiarPersistencia(tipo)
    @persistencia.seleccionar(tipo)
  end
  
end











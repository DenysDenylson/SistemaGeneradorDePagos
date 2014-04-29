require 'singleton'
require 'date'
require 'json'
require 'oj'

class RepositorioEmpleado 
  include Singleton
  def initialize
    @empleados = Array.new
    
    @empleados.push(Empleado.crearEmpleado("111","Juan", "Perez","2014-1-1","false","quincenal","por_hora","50"))
    @empleados.push(Empleado.crearEmpleado("222","Ana", "Lara","2014-4-10","false","mensual","fijo","5000"))
    @empleados.push(Empleado.crearEmpleado("333","Matias", "Soto","2014-2-11","false","trimestral","por_hora","100"))
  end
  
  def guardar(empleado)
    @empleados.push(empleado)
  end
  
  def recuperarEmpleados
    @empleados
  end
  
  def recuperarEmpleadosConSindicato
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
    empleado = @empleados.select{|e| e.ci == ci }
    empleado.first
  end
  
  def actualizar(empleado)
    @empleados.collect!{|e| if e.ci == empleado.ci 
                              e.modificar_atributos(empleado)
                            end
                            e
                      }
  end
  
  def eliminarPorCI(ci)
    @empleados.delete_if{|e| e.ci == ci}
  end
  
  def instanciarNuevo
  	empleado = Empleado.new('', '', '', Date.new(2014,1,1), ContratoMensual.new)
  	empleado.clasificador_salario = ClasificadorSalarioFijo.new(0,Date.today)
  	empleado
	end
	
	def guardarTarjetaDeTiempoParaUnEmpleado(tarjeta_tiempo, ci)
	  @empleados.collect!{|e| if e.ci == ci 
                              e.registrar_tarjeta_de_tiempo(tarjeta_tiempo)
                            end
                            e
                       }
  end
  def recuperarDeArchivo 
    empleados=[]
    File.open('usuarios.json', "r+") do |file| 
    		while linea= file.gets
    			ayudante=Oj.load(linea)
    			empleados.push(ayudante)
    		end
    	end
      @empleados=empleados
  end
  
end











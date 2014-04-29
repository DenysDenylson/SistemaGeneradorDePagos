require 'singleton'
require 'date'

class RepositorioEmpleado 
  include Singleton
  
  def initialize
    @empleados = Array.new
    @persistencia=ArchivoJson.new("empleados.json")
  end
  
  def guardar(empleado)
    @empleados.push(empleado)
    @persistencia.guardarDato(empleado)
  end
  
  def recuperarEmpleados
   /. if @persistencia.verificarExiste?#no estoy seguro lo que quiero hacer es recuperar los usuarios guardados en el archivo de la anterior sesion si este esta creado  pero creo que no va aca
    @empleados=@persistencia.recuperarDatos
    end/
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
    @persistencia.actualizar(@empleados)                  
  end
  
  def eliminarPorCI(ci)
    @empleados.delete_if{|e| e.ci == ci}
    @persistencia.actualizar(@empleados)
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
  
end











require 'json'
require 'oj'
require 'singleton'
require 'date'
class RepositorioJson
  include Singleton
    attr_accessor  :estado_json
  def initialize
    @estado_json=false
  end
  def cambiarEstado
    if recuperarEstado?
      eliminarArchivo
      @estado_json=false
    else
      adicionarTodosLosEmpleados
      @estado_json=true
    end
  end
  def adiccionarEmpleado(empleado)
    File.open("usuarios.json", "a") do |file|
    		  	file.puts(Oj::dump empleado)
    	end	
  end
  
  def adicionarTodosLosEmpleados
    @empleados=RepositorioEmpleado.instance.recuperarEmpleados
    @empleados.each do |empleado|
      adiccionarEmpleado(empleado)
    end
  end
  
  def eliminarArchivo
    File.delete("usuarios.json")
  end
  
  def recuperarEstado?
    @estado_json
  end
end

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
  def cambiarestado
    if@estado_json==false
      @estado_json=true
    else
      @estado=false
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
  def estadotrue?
    @estado
  end
end

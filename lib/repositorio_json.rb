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
      @estado_json=false
    else
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
  
  def recuperarEmpleadoJson
    empleados=[]
    File.open('usuarios.json', "r+") do |file| 
    		while linea= file.gets
    			ayudante=Oj.load(linea)
    			empleados.push(ayudante)
    		end
    	end
    empleados
  end
  
  def verificarExiste?
    resp=false
    if File.exist?("usuarios.json")
      resp=true
    end
    resp
  end
end

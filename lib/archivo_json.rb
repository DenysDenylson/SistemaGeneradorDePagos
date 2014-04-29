require 'json'
require 'oj'
class ArchivoJson
  attr_accessor :archivo
  def initialize(archivo)
     @archivo=archivo
    if verificarExiste?
      eliminarArchivo
    end
  end
  
  def guardarDato(datos)
    File.open(@archivo, "a") do |file|
    		  	file.puts(Oj::dump datos)
    	end	
  end
    
  def eliminarArchivo
    File.delete(@archivo)
  end
  
  def recuperarDatos
    datos=[]
    File.open(@archivo, "r+") do |file| 
    		while linea= file.gets
    			dato=Oj.load(linea)
    			datos.push(dato)
    		end
    	end
   datos
  end
  
  def verificarExiste?
    resp=false
    if File.exist?(@archivo)
      resp=true
    end
    resp
  end
  
end


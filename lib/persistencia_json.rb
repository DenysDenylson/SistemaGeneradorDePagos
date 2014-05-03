require 'json'
require 'oj'
class PersistenciaJSON
  def initialize(archivo)
     @archivo = File.open(archivo,"a")
  end
  
  def cargar_datos(datos)
    eliminarArchivo
    guardarDatos(datos)
  end
  
  def guardar_dato(dato)
    eliminarArchivo
    guardar(dato)
  end
  
  def recuperar_datos
    datos=[]
    File.open(@archivo, "r+") do |file| 
    		while linea= file.gets
    			dato=Oj.load(linea)
    			datos.push(dato)
    		end
    end
    datos
  end
  
  def recuperar_dato
    dato=1
    File.open(@archivo, "r+")do |file| 
    		while linea= file.gets
    			dato=Oj.load(linea)
    		end
    	end
   dato
  end
  
  private
  def guardar(dato)
    File.open(@archivo, "a") do |file|
    		  	file.puts(Oj::dump dato)
    	end	
  end
  
  def guardarDatos(array)
    array.each do |dato|
      guardar(dato)
    end 
  end
    
  def eliminarArchivo
    File.truncate(@archivo,0)
  end
  
  
end


require 'oj'

class PersistenciaJSON
  
  def initialize(archivo)
     @archivo = File.open(archivo,"a")
  end

  def guardar_todos(datos)
    limpiar_archivo
    guardar_arreglo(datos)
  end
  
  def guardar(dato)
    limpiar_archivo
    guardar_dato(dato)
  end
  
  def recuperar_todos
    datos=[]
    File.open(@archivo, "r+") do |file| 
      while linea= file.gets
    	  dato=Oj.load(linea)
    		datos.push(dato)
    	end
    end
    datos
  end
  
  def recuperar
    dato = nil
    File.open(@archivo, "r+")do |file| 
      while linea= file.gets
        dato=Oj.load(linea)
      end
    end
    dato
  end
  
  private
  def guardar_dato(dato)
    File.open(@archivo, "a") do |file|
      file.puts(Oj::dump dato)
    end	
  end
  
  def guardar_arreglo(datos)
    datos.each do |dato|
      guardar_dato(dato)
    end 
  end
      
  def limpiar_archivo
    File.truncate(@archivo,0)
  end
  
end



class PersistenciaMemoria
  
  def initialize
    @datos = []
    @dato = 1
  end
  
  def cargar_datos(datos)
    @datos = datos
  end
  
  def recuperar_datos
    @datos
  end
  
  def cargar_dato(dato)
    @dato=dato
  end
  
  def recuperar_dato
    @dato
  end
  
end


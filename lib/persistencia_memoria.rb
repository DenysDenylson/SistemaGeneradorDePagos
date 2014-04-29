
class PersistenciaMemoria
  
  def initialize
    @datos = []
  end
  
  def cargar_datos(datos)
    @datos = datos
  end
  
  def recuperar_datos
    @datos
  end
  
end


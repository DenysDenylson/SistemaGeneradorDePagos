
class PersistenciaMemoria
  
  def initialize
    @datos = []
    @dato = nil
  end
  
  def guardar_todos(datos)
    @datos = datos
  end
  
  def guardar(dato)
    @dato = dato
  end
  
  def recuperar_todos
    @datos
  end
  
  def recuperar
    @dato
  end
  
end


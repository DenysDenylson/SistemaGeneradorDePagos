class RepositorioPersistencia
  attr_accessor :tipo_bd
  def initialize(nombre)
    @memoria=PersistenciaMemoria.new
    @json=PersistenciaJSON.new(nombre)
    @tipo_persistencia=@memoria
  end
  def seleccionar(tipo)
    case (tipo)
    when "json"
      @tipo_persistencia=@json
    when "memoria"
      @tipo_persistencia=@memoria
    end
  end
  def retornarPersistencia
    @tipo_persistencia
  end
  def guardar_todos(datos)
    @tipo_persistencia.guardar_todos(datos)
  end
  def guardar(dato)
    @tipo_persistencia.guardar(dato)
  end
  def recuperar_todos
    @tipo_persistencia.recuperar_todos
  end
  def recuperar
    @tipo_persistencia.recuperar
  end
end
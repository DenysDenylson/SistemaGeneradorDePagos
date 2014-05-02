class RepositorioPersistencia
  attr_accessor :tipo_bd
  def initialize()
    @tipo_bd
  end
  def seleccionar(tipo_db,nombre)
    case (tipo_db)
    when "Json"
      @tipo_db=PersistenciaJSON.new("/db/"+nombre+".json")
    when "Memoria"
      @tipo_db=PersistenciaMemoria.new
  end
  
end
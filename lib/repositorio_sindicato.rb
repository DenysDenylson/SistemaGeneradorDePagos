require 'singleton'
require 'date'

class RepositorioSindicato
  include Singleton
  
  def initialize
    @sindicato =nil
    @persistencia=PersistenciaJSON.new("./db/sindicato.json")
    @sindicato=@persistencia.recuperar_dato
  end
  
  def crear (sindicato)
    @sindicato = sindicato
    @persistencia.guardar_dato(@sindicato)
  end
  
  def modificar (sindicato)
    @sindicato.modificar_datos(sindicato.nombre, sindicato.fecha, sindicato.descuento_fijo)
    @persistencia.guardar_dato(@sindicato)
  end
  
  def retornar_sindicato
    @sindicato
  end
  
  def ya_fue_creado?
    @sindicato != nil
  end
  
  def recuperar_tarjeta_servicio_por (object_id)
    @sindicato.recuperar_tarjeta_servicio_por(object_id)
  end
  
  def agregar_tarjeta_servicio (tarjeta_servicio)
    @sindicato.agregar(tarjeta_servicio)
    @persistencia.guardar_dato(@sindicato)
  end
  
  def modificar_tarjeta_servicio (tarjeta_servicio,id_tarjeta)
    @sindicato.modificar(tarjeta_servicio,id_tarjeta)
    @persistencia.guardar_dato(@sindicato)
  end
  
  def eliminar_tarjeta_servicio_por (id_tarjeta)
    @sindicato.eliminar(id_tarjeta)
    @persistencia.guardar_dato(@sindicato)
  end
  
end
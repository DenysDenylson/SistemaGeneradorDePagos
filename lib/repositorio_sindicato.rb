require 'singleton'
require 'date'

class RepositorioSindicato
  include Singleton
  
  def initialize
    @sindicato = nil
  end
  
  def crear (sindicato)
    @sindicato = sindicato
  end
  
  def modificar (sindicato)
    @sindicato.modificar_datos(sindicato.nombre, sindicato.fecha, sindicato.descuento)
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
  end
  
  def modificar_tarjeta_servicio (tarjeta_servicio,id_tarjeta)
    @sindicato.modificar(tarjeta_servicio,id_tarjeta)
  end
  
  def eliminar_tarjeta_servicio_por (id_tarjeta)
    @sindicato.eliminar(id_tarjeta)
  end
  
end
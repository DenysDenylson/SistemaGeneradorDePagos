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
  
  def retornar_sindicato
    @sindicato
  end
  
  def existe?
    @sindicato == nil
  end
  
  def recuperar_por (object_id)
    @sindicato.recuperar_por(object_id)
  end
  
  def agregar (tarjeta_servicio)
    @sindicato.agregar(tarjeta_servicio)
  end
  
  def modificar (tarjeta_servicio,id_tarjeta)
    @sindicato.modificar(tarjeta_servicio,id_tarjeta)
  end
  
  def eliminar_por (id_tarjeta)
    @sindicato.eliminar(id_tarjeta)
  end
  
end
require 'date'

class Sindicato
  
  attr_accessor :nombre, :fecha, :descuento_fijo, :tarjetas_servicio
  
  def initialize (nombre, fecha, descuento_fijo)
    @nombre = nombre
    @fecha = fecha
    @descuento_fijo = descuento_fijo
    @tarjetas_servicio = []
  end
  
  def modificar_datos (nombre, fecha, descuento_fijo)
    @nombre = nombre
    @fecha = fecha
    @descuento_fijo = descuento_fijo
  end
  
  def agregar (tarjeta_servicio)
    @tarjetas_servicio.push(tarjeta_servicio)
  end
  
  def calcular_servicio_para_empleado (ci_empleado)
    monto_tarjetas = 0
    @tarjetas_servicio.each do |tarjeta| monto_tarjetas += tarjeta.monto end
    @descuento_fijo + monto_tarjetas
  end
  
  ###metodos sin test
  def modificar (tarjeta_servicio, id_tarjeta)
    @tarjetas_servicio.collect!{ |tarjeta| if tarjeta.object_id == id_tarjeta
                                              tarjeta.modificar_datos_con_otra(tarjeta_servicio)
                                          end
                                          tarjeta
                                }
  end
  
  def eliminar (id_tarjeta)
    @tarjetas_servicio.delete_if{|ts| ts.object_id == id_tarjeta}
  end
  
  def modificar_datos_con_otro (sindicato)
    @nombre = sindicato.nombre
    @fecha = sindicato.fecha
    @descuento_fijo = sindicato.descuento_fijo
  end
  
  def self.crear_sindicato(nombre, fecha, descuento_fijo)
    fecha = Date.parse(fecha)
    if descuento_fijo == ""
      descuento_fijo = 0;
    end
    descuento_fijo = descuento_fijo.to_f
    Sindicato.new(nombre,fecha,descuento_fijo)
  end
  ###
  
end
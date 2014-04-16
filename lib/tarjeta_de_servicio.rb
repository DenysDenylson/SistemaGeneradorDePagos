require('date')

class TarjetaDeServicio
  
	attr_accessor :fecha, :ci_empleado, :monto, :descripcion
	
	def initialize(fecha,ci_empleado,monto,descripcion)
		@fecha = fecha
		@ci_empleado = ci_empleado
		@monto = monto
		@descripcion = descripcion
	end
	
	def modificar_datos_con_otra(tarjeta_servicio)
		@fecha = tarjeta_servicio.fecha
		@ci_empleado = tarjeta_servicio.ci_empleado
		@monto = tarjeta_servicio.monto
		@descripcion = tarjeta_servicio.descripcion
  end
  
  ### no existe test
  def self.crear_tarjeta_servicio(fecha,ci_empleado,monto,descripcion)
    fecha = Date.parse(fecha)
    if monto == ""
      monto = 0
    end
    monto = monto.to_f
    TarjetaDeServicio.new(fecha,ci_empleado,monto,descripcion)
  end
  ###
	
end
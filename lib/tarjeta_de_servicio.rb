require('date')

class TarjetaDeServicio
  
	attr_reader :fecha, :id_empledo, :monto, :descripcion
	
	def initialize(fecha,id_empleado,monto,descripcion)
		@fecha = fecha
		@id_empleado = id_empleado
		@monto = monto
		@descripcion = descripcion
	end
	
	def modificar_datos_con_otra(tarjeta_servicio)
		@fecha = tarjeta_servicio.fecha
		@id_empleado = tarjeta_servicio.id_empleado
		@monto = tarjeta_servicio.monto
		@descripcion = tarjeta_servicio.descripcion
  end
	
end
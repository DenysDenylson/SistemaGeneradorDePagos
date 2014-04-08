require 'date'
require 'time'

class TarjetaDeTiempo
  
  attr_accessor :fecha,:id_empleado,:hora_ingreso,:hora_salida
  
	def initialize(fecha,id_empleado,hora_ingreso,hora_salida)
		@fecha = fecha
		@id_empleado = id_empleado
		@hora_ingreso = hora_ingreso
		@hora_salida = hora_salida
	end

	def calcular_horas_trabajadas
		@hora_salida.strftime("%H:%M:%S").to_i - @hora_ingreso.strftime("%H:%M:%S").to_i
	end
	
	def self.crear_tarjeta(fecha,id_empleado,hora_ingreso,hora_salida)
	  fecha = Date.parse(fecha)
	  hora_ingreso = Time.parse(hora_ingreso, Date.today)
	  hora_salida = Time.parse(hora_salida, Date.today)
	  tarjeta_tiempo = TarjetaDeTiempo.new(fecha,id_empleado,hora_ingreso,hora_salida)  
  end
	
end
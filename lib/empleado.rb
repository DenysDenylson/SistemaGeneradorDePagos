require('date')

#ManejadorEmpleado#
class Empleado
  
  attr_accessor :nombre, :apellido, :ci, :clasificador_salario, :clasificador_contrato, :fecha_inicio_contrato

  def initialize(ci, nombre, apellido, fecha_inicio_contrato,clasificador_contrato)
    @ci = ci
    @nombre = nombre
    @apellido = apellido
    @fecha_inicio_contrato = fecha_inicio_contrato

    @descuento_fijo_por_sindicato = 0
    @tarjetas_de_servicio = Array.new
    @descuento_por_servicios = 0
    @clasificador_contrato=clasificador_contrato
  end
    #revisar este metodo#
  def es_dia_pago?(fecha)
    @clasificador_contrato.es_dia_pago?(fecha)
  end
  
  #revisar este metodo#
  def asignar_salario_fijo(monto)
     @clasificador_salario.salario = monto
  end

  #revisar este metodo#
  def asignar_fecha_inicio_contrato(fecha)
    @clasificador_salario.fecha_inicio_contrato = fecha
  end

  #revisar este metodo#
  def calcular_salario(fecha_ejecucion)
    @clasificador_salario.calcular_salario(fecha_ejecucion) - @descuento_fijo_por_sindicato - calcular_monto_por_servicios_sindicato
  end


  def asignar_descuento_sindicato(monto)
    @descuento_fijo_por_sindicato = monto
  end

  #revisar este metodo#
  def registrar_tarjeta_de_servicio(tarjeta_de_servicio)
    @tarjetas_de_servicio.push(tarjeta_de_servicio)
  end

  #revisar este metodo (diccionario en ahorcado)#
  def calcular_monto_por_servicios_sindicato
    @tarjetas_de_servicio.each { |t| @descuento_por_servicios += t.monto}
    @descuento_por_servicios
  end

  #revisar este metodo#
  def asignar_pago_por_hora(monto)
    @clasificador_salario.monto_por_hora = monto
  end
  
  
  def registrar_tarjeta_de_tiempo(tarjeta_de_tiempo)
    @clasificador_salario.registrar_tarjeta_de_tiempo(tarjeta_de_tiempo)
  end

end
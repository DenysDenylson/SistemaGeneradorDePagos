class GeneradorCheque
  
  def initialize(fecha_de_ejecucion)
    @fecha_de_ejecucion = fecha_de_ejecucion
  end

  def ejecutar(empleado)
    if(empleado.es_dia_pago?(@fecha_de_ejecucion))
      beneficiario = empleado.nombre+ " " +empleado.apellido
      monto = empleado.calcular_salario(@fecha_de_ejecucion)

      return cheque = Cheque.new(empleado.ci,beneficiario,@fecha_de_ejecucion,monto)
    end
    nil
  end
  
end

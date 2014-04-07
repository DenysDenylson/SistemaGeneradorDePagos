class ClasificadorSalarioFijo
  attr_writer :salario, :fecha_inicio_contrato

  def initialize(salario, fecha_inicio_contrato)
    @salario = salario
    @fecha_inicio_contrato = fecha_inicio_contrato
  end

  def calcular_salario(fecha_ejecucion)
    if (ha_sido_contratado_este_mes?(fecha_ejecucion))
      return calcular_salario_prorrateado(fecha_ejecucion)
    end
    @salario
  end
  
  #### metodos sin test
  def esSalarioFijo?
    true
  end
  
  def esSalarioPorHora?
    false
  end
  
  def devolver_salario
    @salario
  end
  ####

  private
  def calcular_salario_prorrateado(fecha_ejecucion)
    dias_trabajados = calcular_dias_trabajados_hasta(fecha_ejecucion)
    salario_diario = calcular_salario_diario(fecha_ejecucion)
    salario_diario * dias_trabajados
  end
  
# -1 es la forma de obtener el ultimo dia del mes
  def calcular_salario_diario(fecha_ejecucion)
    ultimo_dia_del_mes = -1
    fact_salario = @salario / (Date.new(fecha_ejecucion.year, fecha_ejecucion.month, ultimo_dia_del_mes)).day
  end

# + 1 se usa porque 10 - 1 = 9 pero no cuenta el mismo dia que empezo a trabajar
  def calcular_dias_trabajados_hasta(fecha_ejecucion)
    dia_que_empezo_a_trabajar = 1
    dias_trabajados = (fecha_ejecucion - @fecha_inicio_contrato) + dia_que_empezo_a_trabajar
  end

  def ha_sido_contratado_este_mes?(fecha_ejecucion)
    @fecha_inicio_contrato.month==fecha_ejecucion.month && @fecha_inicio_contrato.year==fecha_ejecucion.year
  end
  
end
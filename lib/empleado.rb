require('date')

#ManejadorEmpleado#
class Empleado
  
  attr_accessor :nombre, :apellido, :ci, :clasificador_salario, :clasificador_contrato, :fecha_inicio_contrato, :tiene_sindicato

  def initialize(ci, nombre, apellido, fecha_inicio_contrato,clasificador_contrato)
    @ci = ci
    @nombre = nombre
    @apellido = apellido
    @fecha_inicio_contrato = fecha_inicio_contrato
    @clasificador_contrato = clasificador_contrato
    @tiene_sindicato = false
  end
    #revisar este metodo#
  def es_dia_pago?(fecha)
    @clasificador_contrato.es_dia_pago?(fecha)
  end
  
  #revisar este metodo#
  def asignar_salario(monto)
     @clasificador_salario.salario = monto
  end

  #revisar este metodo#
  def asignar_fecha_inicio_contrato(fecha)
    @clasificador_salario.fecha_inicio_contrato = fecha
  end

  #revisar este metodo#
  def calcular_salario(fecha_ejecucion)
    @clasificador_salario.calcular_salario(fecha_ejecucion)
  end
  
  def registrar_tarjeta_de_tiempo(tarjeta_de_tiempo)
    @clasificador_salario.registrar_tarjeta_de_tiempo(tarjeta_de_tiempo)
  end

##pruebas para la UI

  def self.crearEmpleado(ci, nombre, apellido, fecha_inicio_contrato, tiene_sindicato, tipo_contrato, tipo_salario, salario)
    clasificador_contrato = crear_tipo_contrato(tipo_contrato)
    fecha_inicio_contrato = Date.parse(fecha_inicio_contrato)
    empleado = Empleado.new(ci, nombre, apellido, fecha_inicio_contrato, clasificador_contrato)
    salario = salario.to_f
    empleado.string_to_bool(tiene_sindicato)
    empleado.crear_tipo_salario(tipo_salario, salario)
    empleado
  end

  def devolver_salario
    @clasificador_salario.devolver_salario
  end

  def esContratoMensual?
    @clasificador_contrato.esContratoMensual?
  end
  
  def esContratoQuincenal?
    @clasificador_contrato.esContratoQuincenal?
  end
  
  def esContratoTrimestral?
    @clasificador_contrato.esContratoTrimestral?
  end
  
  def esSalarioFijo?
    @clasificador_salario.esSalarioFijo?
  end
  
  def esSalarioPorHora?
    @clasificador_salario.esSalarioPorHora?
  end
  
  def self.crear_tipo_contrato(tipo_contrato)
    case tipo_contrato
    when "quincenal"
      clasificador_contrato = ContratoQuincenal.new
    when "mensual"
      clasificador_contrato = ContratoMensual.new
    when "trimestral"
      clasificador_contrato = ContratoTrimestral.new
    end
    clasificador_contrato
  end
  
  def cambiar_clasificador_contrato(clasificador_contrato)
    @clasificador_contrato = clasificador_contrato
  end

  def crear_tipo_salario(tipo_salario,salario)
    case tipo_salario
    when "fijo"
      @clasificador_salario = ClasificadorSalarioFijo.new(salario, @fecha_inicio_contrato)
    when "por_hora"
      @clasificador_salario = ClasificadorPorHora.new(salario)
    end
  end
  
  def string_to_bool(tiene_sindicato)
    if tiene_sindicato == "true"
      @tiene_sindicato = true
    else
      @tiene_sindicato = false
    end
  end
  
  def modificar_atributos(empleado)
    @ci = empleado.ci
    @nombre = empleado.nombre
    @apellido = empleado.apellido
    @fecha_inicio_contrato = empleado.fecha_inicio_contrato
    @clasificador_contrato = empleado.clasificador_contrato
    @clasificador_salario.salario = empleado.devolver_salario
    if @clasificador_salario.class != empleado.clasificador_salario.class
      @clasificador_salario = empleado.clasificador_salario
    end
    @tiene_sindicato = empleado.tiene_sindicato
  end
  
  
  
  
end


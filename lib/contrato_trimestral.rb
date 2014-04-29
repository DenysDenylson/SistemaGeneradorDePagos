require 'date'

class ContratoTrimestral
  
  def es_dia_pago?(fecha)
    fecha = fecha.next_day
    crear_variables
    crear_fechas_especificas(fecha)
    
    case fecha
    when @primer_dia_abril
      return true 
    when @primer_dia_julio
      return true
    when @primer_dia_octubre
      return true
    when @primer_dia_enero
      return true
    else 
      return false
    end
  end
  
  def esContratoMensual?
    false
  end
  
  def esContratoQuincenal?
    false
  end
  
  def esContratoTrimestral?
    true
  end
  
  private 
  def crear_variables
    @abril = 4
    @julio = 7
    @octubre = 10
    @enero = 1
    @primer_dia_del_mes = 1
  end
  
  def crear_fechas_especificas(fecha)
    @primer_dia_abril = Date.new(fecha.year,@abril,@primer_dia_del_mes)
    @primer_dia_julio = Date.new(fecha.year,@julio,@primer_dia_del_mes)
    @primer_dia_octubre = Date.new(fecha.year,@octubre,@primer_dia_del_mes)
    @primer_dia_enero = Date.new(fecha.year,@enero,@primer_dia_del_mes)
  end
  
end
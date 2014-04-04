require 'date'

class ContratoTrimestral
  
  def es_dia_pago?(fecha)
    @abril = 4
    @julio = 7
    @octubre = 10
    @enero = 1
    @primer_dia_del_mes = 1
    @un_anio = 1 
    
    fecha = fecha.next_day
    
    primer_dia_abril = Date.new(fecha.year,@abril,@primer_dia_del_mes)
    primer_dia_julio = Date.new(fecha.year,@julio,@primer_dia_del_mes)
    primer_dia_octubre = Date.new(fecha.year,@octubre,@primer_dia_del_mes)
    primer_dia_enero = Date.new(fecha.year,@enero,@primer_dia_del_mes)
    
    case fecha
    when primer_dia_abril
      respuesta = true 
    when primer_dia_abril
      respuesta = true
    when primer_dia_abril
      respuesta = true
    when primer_dia_abril
      respuesta = true
    else 
      respuesta = false
    end
    
    respuesta
  end
  
  def esContratoMensual?
    false
  end
  
  def esContratoQuincenal?
    true
  end
  
end
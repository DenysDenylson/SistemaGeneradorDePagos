class ContratoMensual
  
  #tomese en cuenta que los meses tienen mas o menos dias, 
  #en consecuencia este metodo garantiza que es el ultimo dia del mes
  def es_dia_pago?(fecha_de_ejecucion)
    return (fecha_de_ejecucion.next_day.day==1)
  end
  
  def esContratoMensual?
    true
  end
  
  def esContratoQuincenal?
    false
  end
  
  def esContratoTrimestral?
    false
  end
  
end
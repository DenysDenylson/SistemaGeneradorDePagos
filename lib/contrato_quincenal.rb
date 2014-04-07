#el pago de salario se realiza cada viernes, por que es quincenal?
class ContratoQuincenal
  
  def es_dia_pago?(fecha_de_ejecucion)
    fecha_de_ejecucion.friday?
  end
  
  def esContratoMensual?
    false
  end
  
  def esContratoQuincenal?
    true
  end
  
  def esContratoTrimestral?
    false
  end
  
end
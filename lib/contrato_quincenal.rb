#el pago de salario se realiza cada viernes, por que es quincenal?
class ContratoQuincenal
  
  def es_dia_pago?(fecha_de_ejecucion)
    fecha_de_ejecucion.strftime("%A") == "Friday"
  end
  
end
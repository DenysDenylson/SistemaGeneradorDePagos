require 'singleton'
require 'date'

class RepositorioCheques 
  include Singleton
  
  def generarChequesDe(empleados, sindicato)
    cheques = []
    generador = GeneradorCheque.new(Date.new(2011,9,30))
    empleados.each do |empleado| cheques.push(generador.ejecutar(empleado,sindicato)) end
    cheques
  end
  
end
require 'singleton'
require 'date'

class RepositorioCheques 
  include Singleton
  
  def generarChequesDe(empleados)
    cheques = []
    generadorCheques = GeneradorCheque.new(Date.new(2011,9,30))
    empleados.each do |e| cheques.push(generadorCheques.ejecutar(e))
    end
    cheques
  end
  
end
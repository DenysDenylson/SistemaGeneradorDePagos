require 'singleton'
require 'date'

class RepositorioCheques 
  include Singleton
  
  def generarChequesDe(empleados)
    cheques = []
    generadorCheques = GeneradorCheque.new(Date.new(2014,4,30))
    empleados.each do |e| cheques.push(generadorCheques.ejecutar(e))
    end
    cheques
  end
  
end
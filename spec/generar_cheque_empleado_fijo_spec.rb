require('empleado')
require('generador_cheque')
require('cheque')
require('tarjeta_de_servicio')
require('clasificador_salario_fijo')
require('contrato_trimestral')
require('contrato_mensual')
require 'date'

describe "Generar cheque para empleado con salario fijo" do

  subject(:empleado) {Empleado.crearEmpleado("3343","Juan", "Perez","2013-1-1","false","mensual","fijo","500")}
  subject(:generador) {GeneradorCheque.new(Date.new(2013,6,30))}

  context "Salario Correspondiente" do
    
    subject(:sindicato) {Sindicato.new("6_agosto", Date.new(2013,1,1), 0)}

    it "el cheque generado deberia corresponder al empleado y contener sus datos" do
      cheque = generador.ejecutar(empleado,sindicato)
      cheque.beneficiario.should == "Juan Perez"
      cheque.ci.should == "3343"
      cheque.fecha_emision.should == (Date.new(2013,6,30))
    end

    it "si no es fin de mes no deberia generar el cheque"do
      generador=GeneradorCheque.new(Date.new(2013,4,9))
      cheque=generador.ejecutar(empleado,sindicato)
      cheque.should==nil
    end
    
    it "deberia generar cheque por el monto correspondiente para un empleado" do
      cheque = generador.ejecutar(empleado,sindicato)
      cheque.monto.should == 500
    end

    it "deberia generar cheque con salario completo para un empleado que se contrato el primero del mes" do
      empleado.asignar_fecha_inicio_contrato(Date.new(2013,6,1))
      cheque = generador.ejecutar(empleado,sindicato)
      cheque.monto.to_i.should == 500
    end

    it "deberia generar cheque con mitad de salario para un empleado que se contrato a mitad del mes" do
      empleado.asignar_fecha_inicio_contrato(Date.new(2013,6,16))
      cheque = generador.ejecutar(empleado,sindicato)
      cheque.monto.to_i.should == 250
    end
    
    it "a un empleado trimestral es cada 3 meses" do
      empleado.cambiar_clasificador_contrato(ContratoTrimestral.new)
      cheque = generador.ejecutar(empleado,sindicato)
      cheque.monto.should == 500
    end
  end

  context "Descuentos por sindicato" do
    
    subject(:empleado) {Empleado.crearEmpleado("3343","Juan", "Perez","2013-1-1","true","mensual","fijo","500")}
    
    subject(:sindicato) {Sindicato.new("6_agosto", Date.new(2013,1,1), 100)}
    
    it "si el empleado pertenece a sindicato deberia aplicarse descuento fijo" do
      cheque = generador.ejecutar(empleado,sindicato)
      cheque.monto.should == 400
    end

    it "empleado que solicita un servicio de sindicato deberia aplicarse descuento" do
      tarjeta_servicio = TarjetaDeServicio.new(Date.new(2013,4,20),empleado.ci,100,'pulperia')
      sindicato.agregar(tarjeta_servicio)
      cheque = generador.ejecutar(empleado,sindicato)
      cheque.monto.should == 300
    end

    it "empleado que solicita mas de un servicio de sindicato deberia aplicarse descuento" do
      tarjeta_servicio_1 = TarjetaDeServicio.new(Date.new(2013,4,20),empleado.ci,100,'pulperia')
      tarjeta_servicio_2 = TarjetaDeServicio.new(Date.new(2013,4,21),empleado.ci,50,'pulperia')
      tarjeta_servicio_3 = TarjetaDeServicio.new(Date.new(2013,4,22),empleado.ci,150,'pulperia')
      sindicato.agregar(tarjeta_servicio_1)
      sindicato.agregar(tarjeta_servicio_2)
      sindicato.agregar(tarjeta_servicio_3)
      cheque = generador.ejecutar(empleado,sindicato)
      cheque.monto.should == 100
    end
    
  end
end
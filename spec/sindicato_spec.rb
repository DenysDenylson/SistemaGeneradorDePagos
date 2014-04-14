require 'sindicato'
require 'date'

describe "Un sindicato" do 
  
  subject(:sindicato) {Sindicato.new("14_Septiembre", Date.new(2014,4,10), 100)}
  
  context "al momento de crearse" do
    it "deberia tener nombre, fecha y descuento fijo que le fue asignado" do
      sindicato.nombre.should == "14_Septiembre"
      sindicato.fecha.should == Date.new(2014,4,10)
      sindicato.descuento_fijo.should == 100
    end
  end
  
  context "despues de crearse" do
    it "puede modificarse el nombre, la fecha y el descuento fijo" do
      sindicato.modificar_datos("6_Agosto", Date.new(2014,4,15), 250)
      sindicato.nombre.should == "6_Agosto"
      sindicato.fecha.should == Date.new(2014,4,15)
      sindicato.descuento_fijo.should == 250
    end
  end
  
  context "con tarjetas de servicio" do
    it "deberia al momento de crearse estar vacia" do
      sindicato.tarjetas_servicio.should == []
    end
    
    it "deja de estar vacia al momento de agregarse tarjetas" do
      tarjeta_servicio = TarjetaDeServicio.new(Date.new(2014,1,1), "111", 500, "descripcion")
      sindicato.agregar(tarjeta_servicio)
      sindicato.tarjetas_servicio.should_not == []
    end
    
    it "deberia regresar el monto fijo en caso de no tener ninguna tarjeta" do
      sindicato.calcular_servicio_para_empleado("111").should == 100
    end
    
    it "deberia regresar el monto fijo mas las tarjetas de descuento para un CI de empleado" do
      tarjeta_servicio = TarjetaDeServicio.new(Date.new(2014,1,1), "111", 500, "descripcion")
      sindicato.agregar(tarjeta_servicio)
      tarjeta_servicio = TarjetaDeServicio.new(Date.new(2014,1,1), "111", 200, "descripcion")
      sindicato.agregar(tarjeta_servicio)
      tarjeta_servicio = TarjetaDeServicio.new(Date.new(2014,1,1), "111", 300, "descripcion")
      sindicato.agregar(tarjeta_servicio)
      sindicato.calcular_servicio_para_empleado("111").should == 1100
    end
  end
  
end
class AddMoreServicesToService < ActiveRecord::Migration
  def self.up
    Service.create :title=>"American Express",:image_path=>"american_express.jpg"
    Service.create :title=>"Acesso para Deficientes",:image_path=>"acesso_deficientes.jpg"
    Service.create :title=>"Ar Condicionado",:image_path=>"ar_condicionado.jpg"
    Service.create :title=>"Aberto 24 horas",:image_path=>"24.jpg"
    Service.create :title=>"TV LCD",:image_path=>"lcd.jpg"
    Service.create :title=>"Área Fumantes",:image_path=>"area_fumantes.jpg"

    #Exclusão do Banrisul
    service = Service.find_by_title "Banrisul Compras"
    Service.destroy(service.id) if service
  end

  def self.down
    titles = ["American Express","Acesso para Deficientes","Ar Condicionado""Aberto 24 horas","TV LCD","Área Fumantes"]
    for title in titles do
      service = Service.find_by_title title
      Service.destroy(service.id) if service
    end   
  end
end

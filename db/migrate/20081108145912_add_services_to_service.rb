class AddServicesToService < ActiveRecord::Migration
  def self.up
    Service.create :title=>"Banrisul Compras",:image_path=>"banrisul.jpg"
    Service.create :title=>"Dinner's Club",:image_path=>"dinners_club.jpg"
    Service.create :title=>"Estacionamento",:image_path=>"estacionamento.jpg"
    Service.create :title=>"Maestro",:image_path=>"maestro.jpg"
    Service.create :title=>"Mastercard",:image_path=>"mastercard.jpg"
    Service.create :title=>"Rede Shop",:image_path=>"rede_shop.jpg"
    Service.create :title=>"Visa Electron",:image_path=>"visa_electron.jpg"    
  end

  def self.down
    Service.find(:all).each { |i| Service.destroy(i.id)  }
  end
end

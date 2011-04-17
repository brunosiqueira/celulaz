class AddAutonomozServices < ActiveRecord::Migration
  def self.up
    Service.create :title=>"AAUG Brasil",:image_path=>"aaug_brasil.jpg"
    Service.create :title=>"Allianz",:image_path=>"allianz.jpg"
    Service.create :title=>"Amil",:image_path=>"amil.jpg"
    Service.create :title=>"Bradesco Saúde",:image_path=>"bradesco_saude.jpg"
    Service.create :title=>"Dix Saúde",:image_path=>"dix_saude.jpg"
    Service.create :title=>"Gama Odonto",:image_path=>"gama_odonto.jpg"
    Service.create :title=>"Golden Cross",:image_path=>"golden_cross.jpg"
    Service.create :title=>"Interodonto",:image_path=>"interodonto.jpg"
    Service.create :title=>"Odonto Prev",:image_path=>"odonto_prev.jpg"
    Service.create :title=>"Unimed Seguros",:image_path=>"unimed_seguros.jpg"
  end

  def self.down
    titles = ["AAUG Brasil","Allianz","Amil","Bradesco Saúde","Dix Saúde","Gama Odonto",
      "Golden Cross","Interodonto","Odonto Prev","Unimed Seguros"]

    for title in titles do
      service = Service.find_by_title title
      Service.destroy(service.id) if service
    end
  end
end

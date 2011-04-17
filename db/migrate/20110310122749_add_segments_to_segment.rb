class AddSegmentsToSegment < ActiveRecord::Migration
  def self.up
    Segment.create! :name=>"Artista"
    
    Segment.create! :name=>"Arquitetura"

    Segment.create! :name=>"Advocacia"

    Segment.create! :name=>"Associações clássicas"

    Segment.create! :name=>"Automotivo"

    Segment.create! :name=>"Cine/Foto/Som"

    Segment.create! :name=>"Comunicação"

    Segment.create! :name=>"Construção Civil"

    Segment.create! :name=>"Consultoria empresarial"

    Segment.create! :name=>"Contabilidade"

    Segment.create! :name=>"Cursos"

    Segment.create! :name=>"Farmácia"

    Segment.create! :name=>"Hotelaria"

    Segment.create! :name=>"Imobiliaria"

    Segment.create! :name=>"Internet"

    Segment.create! :name=>"Moveis"

    Segment.create! :name=>"Moda"

    Segment.create! :name=>"Engenharia"

    Segment.create! :name=>"Telecomunicações"

    Segment.create! :name=>"Textil/Confecções"

    Segment.create! :name=>"Estética/Beleza"

    Segment.create! :name=>"Mineração/Siderurgia"

    Segment.create! :name=>"Petshop"

    Segment.create! :name=>"Odontologia"

    Segment.create! :name=>"Serviços gerais"
  end

  def self.down
  end
end

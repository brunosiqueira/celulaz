class CreateSegments < ActiveRecord::Migration
  def self.up
    create_table :segments do |t|
      t.string :name,:limit=>100      
    end
    add_index(:segments, :name, :unique=>true)

    Segment.create :name=>'Alimentação'
    Segment.create :name=>'Casa'
    Segment.create :name=>'Comércio'
    Segment.create :name=>'Diversão'
    Segment.create :name=>'Educação'
    Segment.create :name=>'Saúde'
    Segment.create :name=>'Transporte'
    Segment.create :name=>'Viagem'
    Segment.create :name=>'Outros'
    Segment.create :name=>'Autonomos'
  end

  def self.down
    drop_table :segments
  end
end

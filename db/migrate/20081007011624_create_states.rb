class CreateStates < ActiveRecord::Migration
  def self.up
    create_table :states do |t|
      t.string :acronym
      t.string :name

      t.timestamps
    end

    add_index(:states, :acronym, :unique=>true)
    add_index(:states, :name, :unique=>true)

    State.create :name=>'Acre',	:acronym=>'AC'
    State.create :name=>'Alagoas',	:acronym=>'AL'
    State.create :name=>'Amapá',	:acronym=>'AP'
    State.create :name=>'Amazonas',	:acronym=>'AM'
    State.create :name=>'Bahia',	:acronym=>'BA'
    State.create :name=>'Ceará',	:acronym=>'CE'
    State.create :name=>'Distrito Federal',	:acronym=>'DF'
    State.create :name=>'Espírito Santo',	:acronym=>'ES'
    State.create :name=>'Goiás',	:acronym=>'GO'
    State.create :name=>'Maranhão',	:acronym=>'MA'
    State.create :name=>'Mato Grosso',	:acronym=>'MT'
    State.create :name=>'Mato Grosso do Sul',	:acronym=>'MS'
    State.create :name=>'Minas Gerais',	:acronym=>'MG'
    State.create :name=>'Pará',	:acronym=>'PA'
    State.create :name=>'Paraíba',	:acronym=>'PB'
    State.create :name=>'Paraná',	:acronym=>'PR'
    State.create :name=>'Pernambuco',	:acronym=>'PE'
    State.create :name=>'Piauí',	:acronym=>'PI'
    State.create :name=>'Rio de Janeiro',	:acronym=>'RJ'
    State.create :name=>'Rio Grande do Norte',	:acronym=>'RN'
    State.create :name=>'Rio Grande do Sul',	:acronym=>'RS'
    State.create :name=>'Rondônia',	:acronym=>'RO'
    State.create :name=>'Roraima',	:acronym=>'RR'
    State.create :name=>'Santa Catarina',	:acronym=>'SC'
    State.create :name=>'São Paulo',	:acronym=>'SP'
    State.create :name=>'Sergipe',	:acronym=>'SE'
    State.create :name=>'Tocantins',	:acronym=>'TO'
  end

  def self.down
    drop_table :states
  end
end





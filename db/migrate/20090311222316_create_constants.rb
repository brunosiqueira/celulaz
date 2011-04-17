class CreateConstants < ActiveRecord::Migration
  def self.up
    create_table :constants do |t|
      t.string :key
      t.string :value

      t.timestamps
    end

    Constant.create :key=>"agencia_cedente",:value=>"0527"
    Constant.create :key=>"conta_cedente",:value=>"5739694"
    Constant.create :key=>"nome_cedente",:value=>"Célula IP"
    Constant.create :key=>"cnpj_cedente",:value=>"09235033000195"

  end

  def self.down
    drop_table :constants
  end
end

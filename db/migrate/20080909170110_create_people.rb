require "migration_helpers" 

class CreatePeople < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :people do |t|
      t.references :user
      t.string :name
      t.string :cpf, :limit=>14
      t.string :rg,:limit=>50
      t.string :rg_exp,:limit=>50
      t.date :rg_exp_date
      t.date :date_birth

      t.timestamps
    end
    foreign_key(:people, :user_id, :users)
  end

  def self.down
    drop_table :people
  end
end

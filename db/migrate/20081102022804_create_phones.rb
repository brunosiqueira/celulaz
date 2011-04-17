require "migration_helpers"
class CreatePhones < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :phones do |t|
      t.references :company
      t.references :person
      t.string :phone_type,:limit=>20
      t.integer :ddd,:limit=>3
      t.integer :number,:limit=>8

      t.timestamps
    end
    foreign_key(:phones, :company_id, :companies)
    foreign_key(:phones, :person_id, :people)
    add_index(:phones, [:id,:company_id], :unique=>true)
    add_index(:phones, [:id,:person_id], :unique=>true)
  end

  def self.down
    drop_table :phones
  end
end

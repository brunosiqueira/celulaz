require "migration_helpers"
class CreateCompanies < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :companies do |t|
      t.references :user
      t.string :cnpj, :limit=>18
      t.string :razao_social

      t.timestamps
    end
    
    foreign_key(:companies, :user_id, :users)
  end

  def self.down
    drop_table :companies
  end
end

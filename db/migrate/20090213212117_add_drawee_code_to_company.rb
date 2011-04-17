class AddDraweeCodeToCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :drawee_code, :string, :limit=>15
  end

  def self.down
    remove_column :companies, :drawee_code
  end
end

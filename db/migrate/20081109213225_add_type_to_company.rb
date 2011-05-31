class AddTypeToCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :type, :string,:default=>CompanyS.name, :limit=>10,:null=>false
  end

  def self.down
    remove_column :companies, :type
  end
end

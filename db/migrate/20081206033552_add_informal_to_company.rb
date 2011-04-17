class AddInformalToCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :informal, :boolean
  end

  def self.down
    remove_column :companies, :informal
  end
end

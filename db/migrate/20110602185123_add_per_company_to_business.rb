class AddPerCompanyToBusiness < ActiveRecord::Migration
  def self.up
    add_column :businesses, :per_company, :integer
  end

  def self.down
    remove_column :businesses, :per_company
  end
end

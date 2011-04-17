class AddRegisterNumberToCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :register_number, :string
  end

  def self.down
    remove_column :companies, :register_number
  end
end

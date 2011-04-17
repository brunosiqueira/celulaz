class RemoveTypeFromPhone < ActiveRecord::Migration
  def self.up
    remove_column(:phones, :phone_type)
  end

  def self.down
    add_column :phones, :phone_type, :string
  end
end

class AddPolymorphicToPhone < ActiveRecord::Migration
  def self.up
    add_column :phones, :owner_type, :string
    add_column :phones, :owner_id, :integer
  end

  def self.down
    remove_column :phones, :owner_type
    remove_column :phones, :owner_id
  end
end

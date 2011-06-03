class AddValueToBusiness < ActiveRecord::Migration
  def self.up
    add_column :businesses, :value, :float
  end

  def self.down
    remove_column :businesses, :value
  end
end

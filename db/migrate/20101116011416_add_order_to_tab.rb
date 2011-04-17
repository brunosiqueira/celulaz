class AddOrderToTab < ActiveRecord::Migration
  def self.up
    add_column :tabs, :order, :float
  end

  def self.down
    remove_column :tabs, :order
  end
end

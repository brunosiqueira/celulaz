class RemoveShippingDateFromShipping < ActiveRecord::Migration
  def self.up
    remove_column(:shippings, :shipping_date)
  end

  def self.down
    add_column(:shippings, :shipping_date,:date)
  end
end

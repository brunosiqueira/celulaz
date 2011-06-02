class RemovePaymentTypeFromContract < ActiveRecord::Migration
  def self.up
    remove_column(:contracts, :payment_type)
  end

  def self.down
    add_column :contracts, :payment_type, :string
  end
end

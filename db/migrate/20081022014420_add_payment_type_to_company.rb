class AddPaymentTypeToCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :payment_type, :string, :limit=>10, :default=>"mensal"
  end

  def self.down
    remove_column :companies, :payment_type
  end
end

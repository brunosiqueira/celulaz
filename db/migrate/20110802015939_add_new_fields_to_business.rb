class AddNewFieldsToBusiness < ActiveRecord::Migration
  def self.up
    add_column :businesses, :voucher_expired_at, :date
    add_column :businesses, :link, :string
    add_column :businesses, :status, :string
  end

  def self.down
    remove_column :businesses, :link
    remove_column :businesses, :voucher_expired_at
    remove_column :businesses, :status
  end
end

class AddProcessingDateToShipping < ActiveRecord::Migration
  def self.up
    add_column :shippings, :processing_date, :date
  end

  def self.down
    remove_column :shippings, :processing_date
  end
end

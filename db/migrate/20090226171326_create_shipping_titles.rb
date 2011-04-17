require "migration_helpers"
class CreateShippingTitles < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :shipping_titles do |t|
      t.references :shipping
      t.references :title
      t.string :status
      t.timestamps
    end

    foreign_key :shipping_titles,:shipping_id,:shippings
    foreign_key :shipping_titles,:title_id,:titles
  end

  def self.down
    drop_table :shipping_titles
  end
end

class CreateShippings < ActiveRecord::Migration
  def self.up
    create_table :shippings do |t|
      t.date :shipping_date
      t.string :code
      t.string :status, :limit=>10,:default=>"Aberto"

      t.timestamps
    end
  end

  def self.down
    drop_table :shippings
  end
end

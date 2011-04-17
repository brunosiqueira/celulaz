class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.references :owner,:polymorphic=>true,:null=>false
      t.string :street
      t.integer :number
      t.string :complement
      t.string :zip,:limit=>10
      t.string :neighborhood
      t.string :city
      t.string :state,:limit=>2

      t.timestamps
    end
    add_index(:addresses, [:owner_id,:owner_type])
  end

  def self.down
    drop_table :addresses
  end
end

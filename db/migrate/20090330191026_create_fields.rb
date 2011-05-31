class CreateFields < ActiveRecord::Migration
  def self.up
    create_table :fields do |t|
      t.integer :owner_id
      t.string :owner_type
      t.integer :order
      t.string :value_type
      t.string :label

      t.timestamps
    end
  end

  def self.down
    drop_table :fields
  end
end

require "migration_helpers"
class CreateMessages < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :messages do |t|
      t.integer :sender_id, :null=>false
      t.integer :receiver_id,:null=>false
      t.string :subject,:limit => 50
      t.string :body
      t.boolean :read,:default => false, :null=>false
      t.timestamps
    end

    foreign_key(:messages, :sender_id, :users)
    foreign_key(:messages, :receiver_id, :users)
  end

  def self.down
    drop_table :messages
  end
end

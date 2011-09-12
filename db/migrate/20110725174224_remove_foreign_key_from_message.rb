require "migration_helpers"
class RemoveForeignKeyFromMessage < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    execute "ALTER TABLE messages DROP FOREIGN KEY fk_messages_receiver_id"
    execute "ALTER TABLE messages DROP FOREIGN KEY fk_messages_sender_id"
  end

  def self.down
    foreign_key(:messages, :receiver_id, :users)
    foreign_key(:messages, :sender_id, :users)
  end
end

class AddDeletedSentBoxToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :deleted_sent_box, :boolean
  end

  def self.down
    remove_column :messages, :deleted_sent_box
  end
end

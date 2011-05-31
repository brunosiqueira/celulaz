class RemoveAnsweredToMessage < ActiveRecord::Migration
  def self.up
    remove_column :messages, :answered
  end

  def self.down
    add_column :messages, :answered, :boolean
  end
end

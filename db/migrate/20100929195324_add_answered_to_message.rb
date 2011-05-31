class AddAnsweredToMessage < ActiveRecord::Migration
  def self.up
    add_column :messages, :answered, :boolean
  end

  def self.down
    remove_column :messages, :answered
  end
end

class AddAnswerIdToMessage < ActiveRecord::Migration
  def self.up
    add_column :messages, :answer_id, :integer
  end

  def self.down
    remove_column :messages, :answer_id
  end
end

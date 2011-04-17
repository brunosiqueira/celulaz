class AddFirstAnswerToMessage < ActiveRecord::Migration
  def self.up
    add_column :messages, :first_answer, :boolean
  end

  def self.down
    remove_column :messages, :first_answer
  end
end

class AddErrorMessageToTitle < ActiveRecord::Migration
  def self.up
    add_column :titles, :error_message, :string
  end

  def self.down
    remove_column :titles, :error_message
  end
end

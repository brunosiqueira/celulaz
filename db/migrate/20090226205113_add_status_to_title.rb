class AddStatusToTitle < ActiveRecord::Migration
  def self.up
    add_column :titles, :status, :string, :default=>"Digitado"
  end

  def self.down
    remove_column :titles, :status
  end
end

class AddShowToAddress < ActiveRecord::Migration
  def self.up
    add_column :addresses, :show, :boolean,:default=>true
  end

  def self.down
    remove_column :addresses, :show
  end
end

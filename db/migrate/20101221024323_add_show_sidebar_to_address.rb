class AddShowSidebarToAddress < ActiveRecord::Migration
  def self.up
    add_column :addresses, :show_sidebar, :boolean,:default=>false
  end

  def self.down
    remove_column :addresses, :show_sidebar
  end
end

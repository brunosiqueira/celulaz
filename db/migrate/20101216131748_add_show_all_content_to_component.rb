class AddShowAllContentToComponent < ActiveRecord::Migration
  def self.up
    add_column :components, :show_all_content, :boolean,:default=>false
  end

  def self.down
    remove_column :components, :show_all_content
  end
end

class AddComponentDecorationToLayout < ActiveRecord::Migration
  def self.up
    add_column :layouts, :component_decoration, :string
  end

  def self.down
    remove_column :layouts, :component_decoration
  end
end

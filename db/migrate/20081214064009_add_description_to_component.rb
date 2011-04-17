class AddDescriptionToComponent < ActiveRecord::Migration
  def self.up
    add_column :components, :description, :string
  end

  def self.down
    remove_column :components, :description
  end
end

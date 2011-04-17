class ChangeDescriptionInComponent < ActiveRecord::Migration
  def self.up
    change_column :components, :description, :text
  end

  def self.down
    change_column :components, :description, :string
  end
end

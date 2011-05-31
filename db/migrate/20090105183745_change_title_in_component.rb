class ChangeTitleInComponent < ActiveRecord::Migration
  def self.up
    change_column :components, :title, :string,:limit=>50
  end

  def self.down
    change_column :components, :title, :string,:limit=>255
  end
end

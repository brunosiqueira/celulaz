class ChangeTitleAtComponent < ActiveRecord::Migration
  def self.up
    change_column :components, :title, :string, :limit=>300
  end

  def self.down
    change_column :components, :title, :string, :limit=>50
  end
end

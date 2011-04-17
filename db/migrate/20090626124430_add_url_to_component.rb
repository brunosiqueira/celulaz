class AddUrlToComponent < ActiveRecord::Migration
  def self.up
    add_column :components, :url, :string
  end

  def self.down
    remove_column :components, :url
  end
end

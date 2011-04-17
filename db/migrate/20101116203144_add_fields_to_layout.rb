class AddFieldsToLayout < ActiveRecord::Migration
  def self.up
    add_column :layouts, :email, :string
    add_column :layouts, :facebook, :string
    add_column :layouts, :orkut, :string
    add_column :layouts, :twitter, :string
    add_column :layouts, :flickr, :string
  end

  def self.down
    remove_column :layouts, :flickr
    remove_column :layouts, :twitter
    remove_column :layouts, :orkut
    remove_column :layouts, :facebook
    remove_column :layouts, :email
  end
end

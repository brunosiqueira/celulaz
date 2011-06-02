class AddSeoFieldsToLayout < ActiveRecord::Migration
  def self.up
    add_column :layouts, :meta_description, :string
    add_column :layouts, :meta_keywords, :string
    add_column :layouts, :analytics, :string
  end

  def self.down
    remove_column :layouts, :analytics
    remove_column :layouts, :meta_keywords
    remove_column :layouts, :meta_description
  end
end

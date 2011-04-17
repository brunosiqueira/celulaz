class AddSideImageUrlToLayout < ActiveRecord::Migration
  def self.up
    add_column :layouts, :side_image_url, :string
  end

  def self.down
    remove_column :layouts, :side_image_url
  end
end

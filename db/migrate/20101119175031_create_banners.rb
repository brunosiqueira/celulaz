class CreateBanners < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :banners do |t|
      t.references :layout, :null=>false
      t.string :url, :null=>false
      t.string :title
      t.timestamps
    end
    foreign_key(:banners, :layout_id, :layouts)
  end

  def self.down
    drop_table :banners
  end
end

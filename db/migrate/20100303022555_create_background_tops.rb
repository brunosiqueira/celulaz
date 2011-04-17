require "migration_helpers"
class CreateBackgroundTops < ActiveRecord::Migration
    extend MigrationHelpers
  def self.up
    create_table :background_tops do |t|
      t.references :layout
      t.string :background_top_file_name
      t.string :background_top_content_type
      t.string :background_top_file_size
      t.timestamps
    end
    foreign_key :background_tops,:layout_id,:layouts

    Layout.find(:all,:conditions=>["my_background_top_file_name is not null"]).each { |l|
      b = BackgroundTop.new(:background_top=>l.my_background_top)
      l.background_tops << b
      url = b.background_top.url(:original)
      l.update_attributes(:background_top=>url[1,url.length])
    }
  end

  def self.down
    drop_table :background_tops
  end
end

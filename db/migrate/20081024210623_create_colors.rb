class CreateColors < ActiveRecord::Migration
  def self.up
    create_table :colors do |t|
      t.string :name, :limit=>6
      t.string :slogan, :limit=>6
      t.string :title, :limit=>6
      t.string :subtitle, :limit=>6
      t.string :checked_menu, :limit=>6
      t.string :unchecked_menu, :limit=>6
      t.string :background_menu, :limit=>6
      t.string :tool_botton, :limit=>6
      t.string :text, :limit=>6
      t.string :tool_body, :limit=>6
      t.string :background, :limit=>6
      t.string :body, :limit=>6

      t.timestamps
    end
  end

  def self.down
    drop_table :colors
  end
end

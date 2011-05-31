class CreateColorTemplates < ActiveRecord::Migration
  def self.up
    create_table :color_templates do |t|
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

    ColorTemplate.create(:name=>"FFFFFF", :slogan=>"FFFF33", :title=>"CC3333", :subtitle=>"FFFF33", :checked_menu=>"FF9933", :unchecked_menu=>"CC3333", :background_menu=>"EC1C24", :tool_botton=>"CC3333", :text=>"000000", :tool_body=>"EDEDED", :background=>"EC1C24", :body=>"EDEDED")
  end

  def self.down
    drop_table :color_templates
  end
end

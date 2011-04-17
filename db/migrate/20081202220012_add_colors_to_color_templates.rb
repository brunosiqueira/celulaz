class AddColorsToColorTemplates < ActiveRecord::Migration
  def self.up
    ColorTemplate.create(:name=>"7B653D",
      :slogan=>"FAAA1C",
      :title=>"7B653D",
      :subtitle=>"FAAA1C",
      :checked_menu=>"FAAA1C",
      :unchecked_menu=>"7B653D",
      :background_menu=>"FFFFFF",
      :tool_botton=>"7B653D",
      :text=>"4D4D4D",
      :tool_body=>"FAF8F2",
      :background=>"E6D9CC",
      :body=>"FAF8F2")

    ColorTemplate.create(:name=>"FFFFFF",
      :slogan=>"F7931E",
      :title=>"2E3191",
      :subtitle=>"F7931E",
      :checked_menu=>"F7931E",
      :unchecked_menu=>"2E3191",
      :background_menu=>"EC1C24",
      :tool_botton=>"2E3191",
      :text=>"000000",
      :tool_body=>"EDEDED",
      :background=>"EC1C24",
      :body=>"EDEDED")
  end

  def self.down
    color = ColorTemplate.find_by_name_and_slogan_and_title "7B653D", "FAAA1C","7B653D"
    ColorTemplate.destroy color.id

    color = ColorTemplate.find_by_name_and_slogan_and_title "FFFFFF", "F7931E","2E3191"
    ColorTemplate.destroy color.id
  end
end

class SetNewValuesInColors < ActiveRecord::Migration
  def self.up
    Color.find(:all).each do |color|
      color.update_attributes(
        :menu_deselected_text=>"ffffff",
        :menu_deselected_background=>color.unchecked_menu,
        :menu_selected_text=>"ffffff",
        :menu_selected_background=>color.checked_menu,
        :menu_hover_text=>"ffffff",
        :menu_hover_background=>color.checked_menu,
        :title_text=>color.title,
        :title_background=>color.body,
        :subtitle_text=>color.title,
        :subtitle_background=>color.body,
        :text_background=>color.body,
        :link_text=>"7B653D",
        :link_background=>"ffffff",
        :body_sidebar=>color.body,
        :border=>color.body
      )
    end
  end

  def self.down
  end
end

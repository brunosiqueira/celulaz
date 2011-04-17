class UpdateColorInColorTemplates < ActiveRecord::Migration
 def self.up
    add_column :color_templates, :menu_deselected_text, :string,:limit=>7
    add_column :color_templates, :menu_deselected_background, :string,:limit=>7
    add_column :color_templates, :menu_selected_text, :string,:limit=>7
    add_column :color_templates, :menu_selected_background, :string,:limit=>7
    add_column :color_templates, :menu_hover_text, :string,:limit=>7
    add_column :color_templates, :menu_hover_background, :string,:limit=>7
    add_column :color_templates, :title_text, :string,:limit=>7
    add_column :color_templates, :title_background, :string,:limit=>7
    add_column :color_templates, :subtitle_text, :string,:limit=>7
    add_column :color_templates, :subtitle_background, :string,:limit=>7
    add_column :color_templates, :text_background, :string,:limit=>7
    add_column :color_templates, :link_text, :string,:limit=>7
    add_column :color_templates, :link_background, :string,:limit=>7
    add_column :color_templates, :body_sidebar, :string,:limit=>7
    add_column :color_templates, :border, :string,:limit=>7
  end

  def self.down
    remove_column :color_templates, :menu_deselected_text
    remove_column :color_templates, :menu_deselected_background
    remove_column :color_templates, :menu_selected_text
    remove_column :color_templates, :menu_selected_background
    remove_column :color_templates, :menu_hover_text
    remove_column :color_templates, :menu_hover_background
    remove_column :color_templates, :title_text
    remove_column :color_templates, :title_background
    remove_column :color_templates, :subtitle_text
    remove_column :color_templates, :subtitle_background
    remove_column :color_templates, :text_background
    remove_column :color_templates, :link_text
    remove_column :color_templates, :link_background
    remove_column :color_templates, :body_sidebar
    remove_column :color_templates, :border
  end
end

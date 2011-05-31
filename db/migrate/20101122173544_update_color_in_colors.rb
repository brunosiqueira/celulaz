class UpdateColorInColors < ActiveRecord::Migration
  def self.up
    add_column :colors, :menu_deselected_text, :string,:limit=>7
    add_column :colors, :menu_deselected_background, :string,:limit=>7
    add_column :colors, :menu_selected_text, :string,:limit=>7
    add_column :colors, :menu_selected_background, :string,:limit=>7
    add_column :colors, :menu_hover_text, :string,:limit=>7
    add_column :colors, :menu_hover_background, :string,:limit=>7
    add_column :colors, :title_text, :string,:limit=>7
    add_column :colors, :title_background, :string,:limit=>7
    add_column :colors, :subtitle_text, :string,:limit=>7
    add_column :colors, :subtitle_background, :string,:limit=>7
    add_column :colors, :text_background, :string,:limit=>7
    add_column :colors, :link_text, :string,:limit=>7
    add_column :colors, :link_background, :string,:limit=>7
    add_column :colors, :body_sidebar, :string,:limit=>7
    add_column :colors, :border, :string,:limit=>7
  end

  def self.down
    remove_column :colors, :menu_deselected_text
    remove_column :colors, :menu_deselected_background
    remove_column :colors, :menu_selected_text
    remove_column :colors, :menu_selected_background
    remove_column :colors, :menu_hover_text
    remove_column :colors, :menu_hover_background
    remove_column :colors, :title_text
    remove_column :colors, :title_background
    remove_column :colors, :subtitle_text
    remove_column :colors, :subtitle_background
    remove_column :colors, :text_background
    remove_column :colors, :link_text
    remove_column :colors, :link_background
    remove_column :colors, :body_sidebar
    remove_column :colors, :border
  end
end

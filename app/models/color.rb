# == Schema Information
# Schema version: 20110315144312
#
# Table name: colors
#
#  id                         :integer(4)      not null, primary key
#  name                       :string(6)
#  slogan                     :string(6)
#  title                      :string(6)
#  subtitle                   :string(6)
#  checked_menu               :string(6)
#  unchecked_menu             :string(6)
#  background_menu            :string(6)
#  tool_botton                :string(6)
#  text                       :string(6)
#  tool_body                  :string(6)
#  background                 :string(6)
#  body                       :string(6)
#  created_at                 :datetime
#  updated_at                 :datetime
#  layout_id                  :string(255)
#  menu_deselected_text       :string(7)
#  menu_deselected_background :string(7)
#  menu_selected_text         :string(7)
#  menu_selected_background   :string(7)
#  menu_hover_text            :string(7)
#  menu_hover_background      :string(7)
#  title_text                 :string(7)
#  title_background           :string(7)
#  subtitle_text              :string(7)
#  subtitle_background        :string(7)
#  text_background            :string(7)
#  link_text                  :string(7)
#  link_background            :string(7)
#  body_sidebar               :string(7)
#  border                     :string(7)
#  name_company_text          :string(7)
#  slogan_company_text        :string(7)
#  footer_background          :string(7)
#  footer_text                :string(7)
#  sidebar_text               :string(7)
#

class Color < ActiveRecord::Base
  belongs_to :layout

  def as_json(options={})
    super(options.merge :only=>[:name, :slogan, :title, :subtitle, :checked_menu, :unchecked_menu, :background_menu, :tool_botton, :text, :tool_body, :background, :body, :menu_deselected_text,
  :menu_deselected_background, :menu_selected_text, :menu_selected_background, :menu_hover_text, :menu_hover_background, :title_text, :title_background,
  :subtitle_text, :subtitle_background, :text_background, :link_text, :link_background, :body_sidebar, :border, :name_company_text, :slogan_company_text,
  :sidebar_text,:footer_background,:footer_text])
  end


end

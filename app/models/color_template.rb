# == Schema Information
# Schema version: 20110416172335
#
# Table name: color_templates
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
#  sidebar_text               :string(7)
#  footer_background          :string(7)
#  footer_text                :string(7)
#

class ColorTemplate < ActiveRecord::Base
end

# == Schema Information
# Schema version: 20110315144312
#
# Table name: components
#
#  id                   :integer(4)      not null, primary key
#  layout_id            :integer(4)
#  type                 :string(255)
#  title                :string(300)
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  description          :text
#  url                  :string(255)
#  font_colors          :string(255)
#  show_name            :boolean(1)      default(TRUE)
#  show_email           :boolean(1)      default(TRUE)
#  show_phone           :boolean(1)      default(TRUE)
#  show_address         :boolean(1)      default(TRUE)
#  show_message         :boolean(1)      default(TRUE)
#  show_all_content     :boolean(1)
#

# To change this template, choose Tools | Templates
# and open the template in the editor.

class ComponentForm < Component
  attr_accessor  :name,:subject,:email,:body,:msn,:phone
end

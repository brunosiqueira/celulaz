# == Schema Information
# Schema version: 20110315144312
#
# Table name: users
#
#  id                        :integer(4)      not null, primary key
#  login                     :string(255)
#  email                     :string(255)
#  crypted_password          :string(40)
#  salt                      :string(40)
#  created_at                :datetime
#  updated_at                :datetime
#  remember_token            :string(255)
#  remember_token_expires_at :datetime
#  activation_code           :string(40)
#  activated_at              :datetime
#  password_reset_code       :string(40)
#  enabled                   :boolean(1)      default(TRUE)
#  type                      :string(255)
#  self_created              :boolean(1)
#  avatar_file_name          :string(255)
#  avatar_content_type       :string(255)
#  avatar_file_size          :integer(4)
#  avatar_updated_at         :datetime
#  domain                    :string(255)
#

# To change this template, choose Tools | Templates
# and open the template in the editor.

class UserSupport < UserDirector
  def subusers
    super - [UserSupport.name]
  end
end

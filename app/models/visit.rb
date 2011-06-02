# == Schema Information
# Schema version: 20110416172335
#
# Table name: visits
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)
#  session     :string(255)
#  ip_address  :string(255)
#  request_url :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Visit < ActiveRecord::Base
end

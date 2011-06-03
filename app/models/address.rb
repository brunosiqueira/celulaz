# == Schema Information
# Schema version: 20110416172335
#
# Table name: addresses
#
#  id           :integer(4)      not null, primary key
#  owner_id     :integer(4)      not null
#  owner_type   :string(255)     not null
#  street       :string(255)
#  number       :integer(4)
#  complement   :string(255)
#  zip          :string(10)
#  neighborhood :string(255)
#  city         :string(255)
#  state        :string(2)
#  created_at   :datetime
#  updated_at   :datetime
#  show         :boolean(1)      default(TRUE)
#  show_sidebar :boolean(1)
#

# To change this template, choose Tools | Templates
# and open the template in the editor.

class Address < ActiveRecord::Base
  validates_presence_of :street, :number, :zip,:neighborhood,:city,:state
  def to_s
    [city,zip,number,street,neighborhood,state,I18n.t(state),'Brasil'].compact.join(" ")
  end
end

# To change this template, choose Tools | Templates
# and open the template in the editor.

class Contact < ModelWithoutDatabase
  attr_accessor :name, :email, :ddd, :phone, :city, :description
  validates_presence_of :name, :email, :description
  validates_format_of :email, :with => /(^([^@\s]+)@((?:[-_a-z0-9]+\.)+[a-z]{2,})$)|(^$)/i
end

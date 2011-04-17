# To change this template, choose Tools | Templates
# and open the template in the editor.

class VisitSchedule < ModelWithoutDatabase
  attr_accessor :name, :email, :ddd, :phone, :address, :city, :subsidiary_id, :segment_id, :time_to_visit, :description
  validates_presence_of :name, :email, :ddd, :phone, :address, :city, :subsidiary_id, :segment_id, :time_to_visit
  validates_format_of :email, :with => /(^([^@\s]+)@((?:[-_a-z0-9]+\.)+[a-z]{2,})$)|(^$)/i
end

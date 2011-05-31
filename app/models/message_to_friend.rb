class MessageToFriend < ModelWithoutDatabase
  attr_accessor :name_from,:email_from,:name_to,:email_to,:company,:observations
  validates_presence_of :email_to,:company
  validates_format_of :email_from, :email_to, :with => /(^([^@\s]+)@((?:[-_a-z0-9]+\.)+[a-z]{2,})$)|(^$)/i, :allow_nil=>true
end

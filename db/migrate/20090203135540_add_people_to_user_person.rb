class AddPeopleToUserPerson < ActiveRecord::Migration
  def self.up
    User.find(:all).each { |user|
        user.person = user.person_old
        user.save!
    }
  end

  def self.down
    UserPerson.destroy_all
  end
end

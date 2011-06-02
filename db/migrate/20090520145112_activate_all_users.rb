class ActivateAllUsers < ActiveRecord::Migration
  def self.up
    users = User.find(:all,:conditions=>{:activated_at=>nil})
    unless users.empty?
      users.each { |user|
        user.update_attribute(:activated_at, Time.now)
        puts "#{user.login} ativado!"
      }
    end
  end

  def self.down
  end
end

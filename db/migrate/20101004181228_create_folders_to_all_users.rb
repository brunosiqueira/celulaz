class CreateFoldersToAllUsers < ActiveRecord::Migration
  def self.up
    users = User.all
    for u in users 
      u.build_inbox
      u.save
    end
  end

  def self.down
    Folder.destroy_all
  end
end

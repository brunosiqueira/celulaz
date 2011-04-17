class AddUserWebAdmIdToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :user_web_adm_id, :string
  end

  def self.down
    remove_column :people, :user_web_adm_id
  end
end

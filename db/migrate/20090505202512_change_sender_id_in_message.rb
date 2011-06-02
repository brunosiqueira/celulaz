class ChangeSenderIdInMessage < ActiveRecord::Migration
  def self.up
    change_column :messages,:sender_id,:integer,:null=>true
  end

  def self.down
    change_column :messages,:sender_id,:integer,:null=>false
  end
end

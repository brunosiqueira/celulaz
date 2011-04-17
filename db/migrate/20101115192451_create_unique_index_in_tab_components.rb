class CreateUniqueIndexInTabComponents < ActiveRecord::Migration
  def self.up
    add_index(:tab_components, [:tab_id,:column,:line], :unique=>true)
  end

  def self.down
    remove_index :tab_components, :column=>[:tab_id,:column,:line]
  end
end

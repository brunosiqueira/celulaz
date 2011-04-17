class AddUniqueIndexToDueDateYourNumberInTitle < ActiveRecord::Migration
  def self.up
    add_index(:titles, [:due_date,:your_number], :unique=>true)
  end

  def self.down
    remove_index :titles, :column=>[:due_date,:your_number]
  end
end

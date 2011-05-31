class AddOurNumberAndYourNumberToTitle < ActiveRecord::Migration
  def self.up
    add_column :titles, :our_number, :string, :limit=>7
    add_column :titles, :your_number, :string, :limit=>10
  end

  def self.down
    remove_column :titles, :your_number
    remove_column :titles, :our_number
  end
end

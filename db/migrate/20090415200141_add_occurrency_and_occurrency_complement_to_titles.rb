class AddOccurrencyAndOccurrencyComplementToTitles < ActiveRecord::Migration
  def self.up
    add_column :titles, :occurrency, :string, :limit=>2
    add_column :titles, :occurrency_complement, :string, :limit=>2
  end

  def self.down
    remove_column :titles, :occurrency_complement
    remove_column :titles, :occurrency
  end
end

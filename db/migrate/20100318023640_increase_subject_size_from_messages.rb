class IncreaseSubjectSizeFromMessages < ActiveRecord::Migration
  def self.up
    change_column :messages, :subject,:string,:limit=>256
  end

  def self.down
    change_column :messages, :subject,:string,:limit=>50
  end
end

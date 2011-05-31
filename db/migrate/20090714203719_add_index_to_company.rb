class AddIndexToCompany < ActiveRecord::Migration
  def self.up
    add_index(:companies, :type)
    add_index(:companies, :razao_social)
  end

  def self.down
    remove_index(:companies, :type)
    remove_index(:companies, :razao_social)
  end
end

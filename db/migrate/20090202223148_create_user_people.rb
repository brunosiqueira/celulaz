
require 'migration_helpers'
class CreateUserPeople < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :user_people do |t|
      t.references :user,:null=>false
      t.references :person,:null=>false
      t.timestamps
    end
    foreign_key :user_people,:user_id,:users
    foreign_key :user_people,:person_id,:people
  end

  def self.down
    drop_table :user_people
  end
end

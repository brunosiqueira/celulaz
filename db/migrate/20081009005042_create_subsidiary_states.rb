class CreateSubsidiaryStates < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    create_table :subsidiary_states do |t|
      t.references :subsidiary
      t.references :state

      t.timestamps
    end    
    foreign_key(:subsidiary_states, :subsidiary_id, :subsidiaries)
    foreign_key(:subsidiary_states, :state_id, :states)
    add_index(:subsidiary_states, [:subsidiary_id,:state_id], :unique=>true)
  end

  def self.down
    drop_table :subsidiary_states
  end
end

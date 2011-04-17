class CreateVisits < ActiveRecord::Migration
  def self.up
    create_table :visits do |t|
      t.integer :user_id
      t.string :session,:size=>32
      t.string :ip_address,:size=>16
      t.string :request_url
      t.timestamps
    end

    add_index(:visits, [:session,:request_url], :unique=>true)
    add_index(:visits, :request_url)
  end

  def self.down
    drop_table :visits
  end
end

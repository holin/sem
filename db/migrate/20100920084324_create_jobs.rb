class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.integer :post_id, :link_id
      t.datetime :done_at
      t.timestamps
    end
    add_index :jobs, :done_at
  end

  def self.down
    remove_index :jobs, :done_at
    drop_table :jobs
  end
end

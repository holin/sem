class AddIsLoopAndThedayToJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :is_loop, :boolean, :default => false
    add_column :jobs, :theday, :string
    add_index :jobs, [:is_loop, :theday]
  end

  def self.down
    remove_index :jobs, [:is_loop, :theday]
    remove_column :jobs, :theday
    remove_column :jobs, :is_loop
  end
end

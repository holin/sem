class AddCanLinkAndWorkerToAccounts < ActiveRecord::Migration
  def self.up
    add_column :accounts, :can_link, :boolean, :default => false
    add_column :accounts, :worker, :string
    add_index :accounts, :can_link
  end

  def self.down
    remove_index :accounts, :can_link
    remove_column :accounts, :worker
    remove_column :accounts, :can_link
  end
end

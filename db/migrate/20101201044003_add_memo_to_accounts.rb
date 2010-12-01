class AddMemoToAccounts < ActiveRecord::Migration
  def self.up
    add_column :accounts, :memo, :string
  end

  def self.down
    remove_column :accounts, :memo
  end
end

class CreatePlans < ActiveRecord::Migration
  def self.up
    create_table :plans do |t|
      t.string :name, :link_ids, :post_ids, :kind, :default => ""
      t.datetime :done_at
      t.timestamps
    end
  end

  def self.down
    drop_table :plans
  end
end

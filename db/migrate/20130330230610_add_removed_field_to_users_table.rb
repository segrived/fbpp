class AddRemovedFieldToUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :removed, :boolean, :default => false
  end
end

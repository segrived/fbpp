class AddDeleteFlagsToPrivateMessagesModel < ActiveRecord::Migration
  def change
    add_column :private_messages, :sender_delete_flag, :boolean, :default => false
    add_column :private_messages, :receiver_delete_flag, :boolean, :default => false
  end
end
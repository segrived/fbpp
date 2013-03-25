class CreatePrivateMessages < ActiveRecord::Migration
  def change
    create_table :private_messages do |t|
      t.references :sender
      t.references :receiver
      t.string :title
      t.text :body
      t.datetime :sendtime
      t.boolean :read

      t.timestamps
    end
    add_index :private_messages, :sender_id
    add_index :private_messages, :receiver_id
  end
end

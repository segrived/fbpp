class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :password_hash
      t.string :password_salt
      t.string :name
      t.string :surname
      t.string :patronymic
      t.date :birthday
      t.datetime :regdate
      t.boolean :banned
      t.boolean :disabled
      t.integer :account_type
      t.timestamps
    end
  end
end

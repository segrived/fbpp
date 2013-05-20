class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.string :key
      t.references :user
      t.datetime :expiry_date

      t.timestamps
    end
    add_index :api_keys, :user_id
  end
end

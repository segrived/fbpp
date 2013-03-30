class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user
      t.text :body
      t.datetime :posttime
      t.boolean :anonymously
      t.integer :mark

      t.timestamps
    end
    add_index :comments, :user_id
  end
end

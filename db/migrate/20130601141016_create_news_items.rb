class CreateNewsItems < ActiveRecord::Migration
  def change
    create_table :news_items do |t|
      t.string :text
      t.references :user
      t.datetime :posttime

      t.timestamps
    end
    add_index :news_items, :user_id
  end
end

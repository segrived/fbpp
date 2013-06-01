class NewItemTextFromStringToText < ActiveRecord::Migration
  def change
    change_column :news_items, :text, :text
  end
end

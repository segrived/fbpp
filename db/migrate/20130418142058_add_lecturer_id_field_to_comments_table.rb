class AddLecturerIdFieldToCommentsTable < ActiveRecord::Migration
  def change
    add_column :comments, :lecturer_id, :integer, :after => :user_id
    add_index :comments, :lecturer_id
  end
end

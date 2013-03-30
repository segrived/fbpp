class CreateLecturerComments < ActiveRecord::Migration
  def change
    create_table :lecturer_comments do |t|
      t.references :comment
      t.references :lecturer

      t.timestamps
    end
    add_index :lecturer_comments, :comment_id
    add_index :lecturer_comments, :lecturer_id
  end
end

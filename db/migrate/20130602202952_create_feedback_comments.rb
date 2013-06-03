class CreateFeedbackComments < ActiveRecord::Migration
  def change
    create_table :feedback_comments do |t|
      t.references :feedback
      t.references :comment

      t.timestamps
    end
    add_index :feedback_comments, :feedback_id
    add_index :feedback_comments, :comment_id
  end
end

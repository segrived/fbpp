class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.references :student
      t.references :subject_subscription
      t.datetime :time

      t.timestamps
    end
    add_index :feedbacks, :student_id
    add_index :feedbacks, :subject_subscription_id
  end
end

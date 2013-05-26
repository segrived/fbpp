class CreateFeedbackAnswers < ActiveRecord::Migration
  def change
    create_table :feedback_answers do |t|
      t.reference :feedback
      t.reference :question
      t.integer :answer

      t.timestamps
    end
  end
end

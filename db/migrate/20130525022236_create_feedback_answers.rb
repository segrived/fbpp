class CreateFeedbackAnswers < ActiveRecord::Migration
  def change
    create_table :feedback_answers do |t|
      t.references :feedback
      t.references :question
      t.integer :answer

      t.timestamps
    end
  end
end

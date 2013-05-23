class CreateSubjectSubscriptions < ActiveRecord::Migration
  def change
    create_table :subject_subscriptions do |t|
      t.references :subject
      t.references :lecturer

      t.timestamps
    end
    add_index :subject_subscriptions, :subject_id
    add_index :subject_subscriptions, :lecturer_id
  end
end

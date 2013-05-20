class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.references :user
      t.references :specialty
      t.integer :course

      t.timestamps
    end
    add_index :students, :user_id
    add_index :students, :specialty_id
  end
end

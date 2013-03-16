class CreateLecturers < ActiveRecord::Migration
  def change
    create_table :lecturers do |t|
      t.references :user
      t.references :departament
      t.integer :degree

      t.timestamps
    end
    add_index :lecturers, :user_id
    add_index :lecturers, :departament_id
  end
end

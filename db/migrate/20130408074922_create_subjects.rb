class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.text :description
      t.references :departament

      t.timestamps
    end
    add_index :subjects, :departament_id
  end
end

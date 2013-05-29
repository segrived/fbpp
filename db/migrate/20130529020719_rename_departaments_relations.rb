class RenameDepartamentsRelations < ActiveRecord::Migration
  def change
    rename_column :lecturers, :departament_id, :department_id
    rename_column :subjects, :departament_id, :department_id
  end
end

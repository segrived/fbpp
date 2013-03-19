class ConvertLecurerDegreeFieldToId < ActiveRecord::Migration
  def change
    rename_column :lecturers, :degree, :scientific_degree_id
    add_index :lecturers, :scientific_degree_id
  end
end

class AddConfirmFieldToLectureModel < ActiveRecord::Migration
  def change
    add_column :lecturers, :confirm_level, :integer, :default => 0
  end
end

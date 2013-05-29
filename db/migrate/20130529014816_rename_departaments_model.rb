class RenameDepartamentsModel < ActiveRecord::Migration
  def change
    rename_table :departaments, :departments
  end
end

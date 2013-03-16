class CreateSpecialties < ActiveRecord::Migration
  def change
    create_table :specialties do |t|
      t.string :code
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end

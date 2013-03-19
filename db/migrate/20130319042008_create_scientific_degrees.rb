class CreateScientificDegrees < ActiveRecord::Migration
  def change
    create_table :scientific_degrees do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end

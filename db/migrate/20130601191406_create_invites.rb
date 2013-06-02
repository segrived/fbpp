class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :code
      t.integer :remains
      t.datetime :expires

      t.timestamps
    end
  end
end

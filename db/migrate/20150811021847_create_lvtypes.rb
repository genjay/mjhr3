class CreateLvtypes < ActiveRecord::Migration
  def change
    create_table :lvtypes do |t|
      t.string :uid
      t.string :name
      t.integer :ou_id
      t.text :memo

      t.timestamps null: false
    end
  end
end

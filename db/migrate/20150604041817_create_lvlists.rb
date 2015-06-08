class CreateLvlists < ActiveRecord::Migration
  def change
    create_table :lvlists do |t|
      t.string :uid
      t.integer :amt
      t.integer :ou_id

      t.timestamps null: false
    end
  end
end

class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :uid
      t.string :name
      t.references :worktype, index: true, foreign_key: true
      t.integer :upper_id
      t.boolean :is_stoped
      t.text :memo
      t.integer :ou_id

      t.timestamps null: false
    end
  end
end

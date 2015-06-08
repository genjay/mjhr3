class CreateOvertypes < ActiveRecord::Migration
  def change
    create_table :overtypes do |t|
      t.string :uid
      t.string :name
      t.integer :mins_of_A
      t.integer :mins_of_B
      t.decimal :rate_of_A, precision: 7, scale: 4
      t.decimal :amt_of_A
      t.decimal :rate_of_B, precision: 7, scale: 4
      t.decimal :amt_of_B
      t.decimal :rate_of_C, precision: 7, scale: 4
      t.decimal :amt_of_C
      t.decimal :rate_of_H, precision: 7, scale: 4
      t.decimal :amt_of_H
      t.integer :mins_per_unit
      t.string :valid_unit
      t.boolean :is_stoped
      t.string :pay_type
      t.text :memo
      t.integer :ou_id

      t.timestamps null: false
    end
  end
end

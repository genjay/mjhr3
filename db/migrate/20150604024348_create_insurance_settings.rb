class CreateInsuranceSettings < ActiveRecord::Migration
  def change
    create_table :insurance_settings do |t|
      t.string :uid
      t.string :name
      t.boolean :is_stoped
      t.text :memo
      t.integer :ou_id
      t.decimal :a_rate, precision: 7, scale: 4
      t.decimal :a_employee
      t.decimal :a_compayny
      t.decimal :b_rate, precision: 7, scale: 4
      t.decimal :b_employee
      t.decimal :b_compayny
      t.decimal :c_rate, precision: 7, scale: 4
      t.decimal :c_employee
      t.decimal :c_compayny
      t.decimal :d_rate, precision: 7, scale: 4
      t.decimal :d_employee
      t.decimal :d_compayny
      t.decimal :e_rate, precision: 7, scale: 4
      t.decimal :e_employee
      t.decimal :e_compayny

      t.timestamps null: false
    end
  end
end

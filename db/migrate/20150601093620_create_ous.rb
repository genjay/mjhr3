class CreateOus < ActiveRecord::Migration
  def change
    create_table :ous do |t|
      t.string :uid
      t.string :name
      t.integer :overwork_hours_for_freetax
      t.integer :days_per_month
      t.integer :hours_per_day
      t.decimal :LP_rate, precision: 5, scale: 2
      t.decimal :welfare_rate, precision: 5, scale: 2
      t.text :memo

      t.timestamps null: false
    end
  end
end

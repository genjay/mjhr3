class CreateOfftypes < ActiveRecord::Migration
  def change
    create_table :offtypes do |t|
      t.string :uid
      t.string :name
      t.integer :mins_of_minimum
      t.integer :mins_per_unit
      t.integer :deduct_percent
      t.boolean :include_holiday
      t.boolean :can_duplicate
      t.boolean :is_quota_ctrl
      t.boolean :is_stoped
      t.text :memo
      t.integer :ou_id

      t.timestamps null: false
    end
  end
end

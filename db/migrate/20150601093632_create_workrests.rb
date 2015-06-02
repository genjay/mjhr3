class CreateWorkrests < ActiveRecord::Migration
  def change
    create_table :workrests do |t|
      t.references :worktype, index: true, foreign_key: true
      t.boolean :is_holiday
      t.time :rest_begin_at
      t.integer :mins_of_rest
      t.boolean :is_deduct_for_duty
      t.text :memo
      t.integer :ou_id

      t.timestamps null: false
    end
  end
end

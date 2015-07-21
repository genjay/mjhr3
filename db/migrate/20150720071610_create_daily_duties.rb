class CreateDailyDuties < ActiveRecord::Migration
  def change
    create_table :daily_duties do |t|
      t.integer :employee_id, null: false
      t.date :duty_date, null: false
      t.boolean :is_holiday 
      t.integer :worktype_id 
      t.integer :over_a, default: 0
      t.integer :over_b, default: 0
      t.integer :over_c, default: 0
      t.integer :over_h, default: 0
      t.datetime :real_on
      t.datetime :real_off
      t.integer :ou_id

      t.timestamps null: false
    end
  end
end

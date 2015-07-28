class CreateDailyDutyOfftypes < ActiveRecord::Migration
  def change
    create_table :daily_duty_offtypes do |t|
      t.integer :daily_duty_id
      t.integer :offtype_id
      t.integer :minutes

      t.timestamps null: false
    end
  end
end

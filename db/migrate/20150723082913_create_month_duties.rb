class CreateMonthDuties < ActiveRecord::Migration
  def change
    create_table :month_duties do |t|
      t.integer :ou_id
      t.integer :employee_id
      t.integer :yyyymm

      t.timestamps null: false
    end
  end
end

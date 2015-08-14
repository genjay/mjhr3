class CreateMonthSalaries < ActiveRecord::Migration
  def change
    create_table :month_salaries do |t|
      t.integer :employee_id,null: false
      t.integer :yyyymm,null: false
      t.integer :ou_id,null: false
      t.integer :pay_type_id,null: false
      t.integer :amt, default: 0

      t.timestamps null: true
    end
  end
end

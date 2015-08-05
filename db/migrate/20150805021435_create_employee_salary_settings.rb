class CreateEmployeeSalarySettings < ActiveRecord::Migration
  def change
    create_table :employee_salary_settings do |t|
      t.integer :employee_id
      t.integer :pay_type_id
      t.integer :ou_id
      t.integer :amt
      t.text :memo

      t.timestamps null: false
    end
  end
end

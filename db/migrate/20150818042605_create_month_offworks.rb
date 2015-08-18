class CreateMonthOffworks < ActiveRecord::Migration
  def change
    create_table :month_offworks do |t|
      t.integer :ou_id
      t.integer :employee_id
      t.integer :yyyymm
      t.integer :offtype_id
      t.integer :mins_of_duty
      t.integer :deduct_percent

      t.timestamps null: true
    end
  end
end

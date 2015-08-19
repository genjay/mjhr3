class CreateMonthOthers < ActiveRecord::Migration
  def change
    create_table :month_others do |t|
      t.integer :ou_id
      t.integer :employee_id
      t.integer :yyyymm
      t.integer :pay_type_id
      t.integer :amt

      t.timestamps null: false
    end
  end
end

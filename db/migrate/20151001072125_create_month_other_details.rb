class CreateMonthOtherDetails < ActiveRecord::Migration
  def change
    create_table :month_other_details do |t|
      t.integer :ou_id
      t.string :month_other_id
      t.integer :employee_id
      t.integer :amt

      t.timestamps null: false
    end
  end
end

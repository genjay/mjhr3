class CreateEmployeeInoutlogs < ActiveRecord::Migration
  def change
    create_table :employee_inoutlogs do |t|
    	t.integer :employee_id
    	t.string :action
    	t.date :begin_at
    	t.integer :department_id
    	t.integer :days_of_jobage

      t.timestamps null: false
    end
  end
end

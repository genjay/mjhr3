class AddUniqueIndexOnSchempSchdep < ActiveRecord::Migration
  def change
  	add_index :sch_emps, [:employee_id, :duty_date], unique: true
  	add_index :sch_deps, [:department_id, :duty_date], unique: true
  end
end

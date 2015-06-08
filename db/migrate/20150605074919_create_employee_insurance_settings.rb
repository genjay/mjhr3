class CreateEmployeeInsuranceSettings < ActiveRecord::Migration
  def change
    create_table :employee_insurance_settings do |t|
    	t.integer :employee_id
    	t.integer :NHI_LV
    	t.date :NHI_begin_at
    	t.date :NHI_end_at
    	t.string :NHI_subsidy_id
    	t.integer :labor_lv
    	t.date :labor_begin_at
    	t.date :labor_end_at
    	t.integer :labor_subsidy_id
    	t.integer :LP_Lv
    	t.date :LP_begin_at
    	t.date :LP_end_at
    	t.string :LP_subsidy_id
    	t.boolean :is_free_for_2nd
    	t.text :reson_for_free2nd
    	t.text :memo
    	t.integer :ou_id

      t.timestamps null: false
    end
  end
end

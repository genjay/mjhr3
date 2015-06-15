class CreateSchDeps < ActiveRecord::Migration
  def change
    create_table :sch_deps do |t|
      t.integer :ou_id
      t.date :duty_date
      t.boolean :is_holiday 
      t.integer :worktype_id
      t.integer :department_id 

      t.timestamps null: false
    end
  end
end

class CreateDocForgets < ActiveRecord::Migration
  def change
    create_table :doc_forgets do |t|
      t.string :doc_no
      t.integer :employee_id
      t.date :duty_date
      t.datetime :on_duty_at
      t.datetime :off_duty_at
      t.boolean :is_closed
      t.integer :ou_id

      t.timestamps null: false
    end

    add_index :doc_forgets, [:ou_id, :doc_no], unique: true
    add_index :doc_forgets, [:employee_id, :duty_date], unique: true 
  end
end

class CreateDocOverworks < ActiveRecord::Migration
  def change
    create_table :doc_overworks do |t|
      t.integer :employee_id
      t.date :duty_date
      t.datetime :overwork_begin_at
      t.datetime :overwork_end_at
      t.integer :mins_of_overwork
      t.boolean :is_closed
      t.integer :ou_id
      t.text :notes

      t.timestamps null: false
    end
    
    add_index :doc_overworks, [:employee_id, :duty_date], unique: true 
  end
end

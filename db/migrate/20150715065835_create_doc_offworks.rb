class CreateDocOffworks < ActiveRecord::Migration
  def change
    create_table :doc_offworks do |t|
      t.integer :employee_id
      t.integer :offtype_id
      t.datetime :offduty_begin_at
      t.datetime :offduty_end_at
      t.string :mins_offduty
      t.boolean :is_closed
      t.integer :ou_id
      t.text :notes

      t.timestamps null: false
    end
  end
end

class CreateAnnualLeaveLists < ActiveRecord::Migration
  def change
    create_table :annual_leave_lists do |t|
      t.integer :months_of_job
      t.integer :days
      t.text :memo
      t.integer :ou_id

      t.timestamps null: false
    end
  end
end

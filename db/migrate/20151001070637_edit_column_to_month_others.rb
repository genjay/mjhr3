class EditColumnToMonthOthers < ActiveRecord::Migration
  def change
  	remove_column :month_others, :employee_id
  	remove_column :month_others, :amt
  	add_column :month_others, :name, :string
  end
end

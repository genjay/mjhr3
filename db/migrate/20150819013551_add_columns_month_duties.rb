class AddColumnsMonthDuties < ActiveRecord::Migration
  def change
  	add_column :month_duties, :dutydays, :integer
  	add_column :month_duties, :range_days, :integer
  end
end

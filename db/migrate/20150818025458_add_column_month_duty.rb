class AddColumnMonthDuty < ActiveRecord::Migration
  def change
  	add_column :month_duties, :duty_fr, :date
  	add_column :month_duties, :duty_to, :date
  end
end

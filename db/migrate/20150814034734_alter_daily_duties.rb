class AlterDailyDuties < ActiveRecord::Migration
  def change
  	add_column :daily_duties, :buffer_before_duty, :integer
  	add_column :daily_duties, :buffer_after_duty, :integer
  	add_column :daily_duties, :delay_used,:integer
  	add_column :employees, :overtype_id, :integer
  end
end

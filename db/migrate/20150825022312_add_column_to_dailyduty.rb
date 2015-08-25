class AddColumnToDailyduty < ActiveRecord::Migration
  def change
  	add_column :daily_duties, :is_closed, :boolean, :default => 0
  end
end

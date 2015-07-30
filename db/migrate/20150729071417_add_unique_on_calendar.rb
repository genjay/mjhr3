class AddUniqueOnCalendar < ActiveRecord::Migration
  def change
  	add_index :calendars, [:ou_id, :duty_date], unique: true
  end
end

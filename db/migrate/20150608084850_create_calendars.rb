class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
    	t.date :duty_date
    	t.boolean :is_holiday
    	t.integer :ou_id

      t.timestamps null: false
    end
  end
end

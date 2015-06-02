class CreateWorktypes < ActiveRecord::Migration
  def change
    create_table :worktypes do |t|
      t.string :uid
      t.string :name
      t.time :on_duty_at
      t.time :off_duty_at
      t.integer :buffer_before_duty
      t.integer :buffer_after_duty
      t.integer :minimum_before_overwork
      t.integer :minimum_after_overwork
      t.integer :minimum_holiday_overwork
      t.integer :range_on
      t.integer :range_off
      t.boolean :is_stoped
      t.integer :mins_of_duty
      t.text :memo
      t.integer :ou_id

      t.timestamps null: false
    end
  end
end

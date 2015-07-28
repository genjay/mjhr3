class AddColumnOnWorktypes < ActiveRecord::Migration
  def change
  	add_column :worktypes, :on_duty_offset, :integer, default: 0
  	add_column :worktypes, :off_duty_offset, :integer, default: 0
  end
end

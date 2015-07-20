class TestCountCache < ActiveRecord::Migration
  def change
	  add_column :departments, :employees_count, :integer, :default => 0
	  
	  Department.pluck(:id).each do |i|
	    Department.reset_counters(i, :employees) # 全部重算一次
	  end
	end
end

class AddViewSalaryBase < ActiveRecord::Migration
  def up
  	sql = IO.read("./sql/view_salary_base.sql")
  	self.connection.execute sql
  end

  def down
  	self.connection.execute %Q(Drop view view_salary_base)
  end
end

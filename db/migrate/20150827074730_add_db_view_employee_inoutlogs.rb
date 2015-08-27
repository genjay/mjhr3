class AddDbViewEmployeeInoutlogs < ActiveRecord::Migration
  def up
  	sql = IO.read("./sql/view_employee_inoutlogs.sql")
  	self.connection.execute (sql) 
  end

  def down 
  	self.connection.execute %Q(Drop view view_view_employee_inoutlogs) 
  end
end

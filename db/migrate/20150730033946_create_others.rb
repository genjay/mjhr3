class CreateOthers < ActiveRecord::Migration
  def up

  	sql = IO.read("./sql/view_sch_emps.sql")
  	self.connection.execute (sql)

  	sql = IO.read("./sql/view_sch_deps.sql")
  	self.connection.execute (sql)

    sql = IO.read("./sql/view_workrests.sql")
    self.connection.execute (sql)

  end

  def down 
  	self.connection.execute %Q(Drop view view_sch_deps)
  	self.connection.execute %Q(Drop view view_sch_emps)
    self.connection.execute %Q(Drop view view_workrests)
  end
end

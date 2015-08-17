class ChangeDbView < ActiveRecord::Migration
  def up
    sql = IO.read("./sql/view_for_overs.sql")
    self.connection.execute (sql)
    
  end

  def down  
    self.connection.execute %Q(Drop view view_for_overs)
  end
end

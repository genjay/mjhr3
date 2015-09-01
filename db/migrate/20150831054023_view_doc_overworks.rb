class ViewDocOverworks < ActiveRecord::Migration
  def up
  	sql = IO.read("./sql/view_doc_overworks.sql")
  	self.connection.execute sql
  end

  def down
  	self.connection.execute %Q(Drop view view_doc_overworks)
  end
end

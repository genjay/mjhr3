class ViewEmployeeInoutlog < ActiveRecord::Base
  def to_s
  	"#{action} #{value}"
  end

  def to_dept_s
  	"#{dept_id} #{dept_name}"
  end
  
  def readonly?
 	true
  end
end
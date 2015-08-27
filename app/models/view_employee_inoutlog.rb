class ViewEmployeeInoutlog < ActiveRecord::Base
  def to_s
  	"#{action} #{value}"
  end
  
	def readonly?
		true
	end
end
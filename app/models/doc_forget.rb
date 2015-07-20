class DocForget < ActiveRecord::Base
	validates :employee_id, :duty_date, uniqueness: {scope: [:employee_id, :duty_date]}

	belongs_to :employee 
	before_destroy :check_is_closed

	def check_is_closed
	  if self.is_closed == true
	  	errors[:messages] << %Q(It's closed can't Delete)
	  	false
	  end
	end

	def duty_info
		ViewSchEmp.find_by(ou_id: ou_id,employee_id: employee_id,duty_date: duty_date)
	end
end

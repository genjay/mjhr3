class MonthOtherDetail < ActiveRecord::Base
	belongs_to :month_other
	belongs_to :employee

	def employee_uid
		self.employee.try(:uid) 
 	end
end

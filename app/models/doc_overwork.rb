class DocOverwork < ActiveRecord::Base
	validates :employee_id, :duty_date, uniqueness: {scope: [:employee_id, :duty_date]}

	belongs_to :employee
	belongs_to :overtype
	before_destroy :check_is_closed

	def check_is_closed
	  if self.is_closed == true
	  	errors[:messages] << %Q(It's closed can't Delete)
	  	false
	  end
	end

end

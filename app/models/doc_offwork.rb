class DocOffwork < ActiveRecord::Base
	validates :employee_id, uniqueness: {scope: [:employee_id]}

	belongs_to :employee
	belongs_to :offtype
	before_destroy :check_is_closed

	def check_is_closed
	  if self.is_closed == true
	  	errors[:messages] << %Q(It's closed can't Delete)
	  	false
	  end
	end
end

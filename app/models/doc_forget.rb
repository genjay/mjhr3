class DocForget < ActiveRecord::Base
	# validates :doc_no, presence: true, uniqueness: {scope: :ou_id, message: "已經被使用"}  
	validates :employee_id, :duty_date, uniqueness: {scope: [:employee_id, :duty_date]}

	belongs_to :employee 
	before_destroy :check_is_closed

	def check_is_closed
	  if self.is_closed == true
	  	errors[:messages] << %Q(It's closed can't Delete)
	  	false
	  end
	end
end

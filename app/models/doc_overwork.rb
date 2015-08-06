class DocOverwork < ActiveRecord::Base
	validates :employee_id, :duty_date, uniqueness: {scope: [:employee_id, :duty_date]}
	validates :hr, :hr_h, inclusion: { :in => 0..24,message:"只能輸入0~24" }

	belongs_to :employee
	belongs_to :overtype
	before_destroy :check_is_closed

	def check_is_closed
	  if self.is_closed == true
	  	errors[:messages] << %Q(It's closed can't Delete)
	  	false
	  end
	end

	def hr # 加班時數，指1750後的加班 
		(self.mins_A + self.mins_B + self.mins_C)/60
	end

	def hr=(hrs)

		mins = hrs.to_i * 60
		self.mins_A = (mins>120)? 120:mins
		mins = mins - mins_A
		self.mins_B = (mins>120)? 120:mins
		mins = mins - mins_B
		self.mins_C = mins
	end

	def hr_h # 假日時數，指 0820~1720 部份
		self.mins_H/60
	end

	def hr_h=(hrs)
		mins = hrs.to_i * 60
		self.mins_H = mins
	end

end

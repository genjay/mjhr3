class Offtype < ActiveRecord::Base
		after_initialize :defaults
	def defaults
		self.mins_of_minimum ||= 60
		self.mins_per_unit ||= 30
		self.deduct_percent ||= 0
		self.include_holiday ||= 0
		self.can_duplicate ||= 0
		self.is_quota_ctrl ||= 0 
	end
end

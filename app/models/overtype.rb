class Overtype < ActiveRecord::Base
		after_initialize :defaults 

	def defaults
		# 請不要在此用會sql自己的語法，可能會無限回圈
		self.mins_of_A ||= 120
		self.mins_of_B ||= 120
		self.rate_of_A ||= 1.3333
		self.rate_of_B ||= 1.6666
		self.rate_of_C ||= 2.0000
		self.rate_of_H ||= 2.0000
		self.amt_of_A  ||= 0
		self.amt_of_B  ||= 0
		self.amt_of_C  ||= 0
		self.amt_of_H  ||= 0 
		self.mins_per_unit ||= 60 
	end
end

class Offtype < ActiveRecord::Base
  belongs_to :ou 


  validates :uid,:name,presence:true, uniqueness: {scope: :ou_id, message: "已經被使用"} 
	validates :mins_of_minimum, inclusion: {in: 1..480, message: "1..480"}
	validates :mins_per_unit, inclusion: {in: 1..480, message: "1..480"}
	validates :deduct_percent, inclusion: {in: 0..100, message: "0..100"}

	after_initialize :assign_default_values
	
	def assign_default_values
		self.mins_of_minimum ||= 60
		self.mins_per_unit   ||= 30
		self.deduct_percent  ||= 0
		self.include_holiday ||= 0
		self.can_duplicate   ||= 0
		self.is_quota_ctrl   ||= 0 
	end
end

class Ou < ActiveRecord::Base
	# default_scope { where(id: nil)}
	after_initialize :defaults
	has_many :worktypes
	has_many :employees
	has_many :view_sch_emps
	has_many :view_sch_deps
	has_many :overtypes
	has_many :departments 

  validates :uid,:name,presence:true 
 	validates :uid,:name, uniqueness: { message: "已經被使用" } 

	def defaults
		# 請不要在此用會sql自己的語法，可能會無限回圈
		self.overwork_hours_for_freetax ||= 46
		self.days_per_month             ||= 30
		self.hours_per_day              ||= 8
		self.LP_rate                    ||= 6
		self.welfare_rate               ||= 0.5 
	end

end

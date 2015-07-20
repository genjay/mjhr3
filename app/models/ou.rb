class Ou < ActiveRecord::Base
  store :settings, :accessors => [:sex, :url]
  validates :uid,:name, presence:true , uniqueness: {message: "已經被使用"} 

	after_initialize :assign_default_values
	after_create :create_environment
	has_many :worktypes, :dependent => :restrict_with_error
	has_many :employees, :dependent => :restrict_with_error 
	has_many :overtypes, :dependent => :restrict_with_error
	has_many :departments, :dependent => :restrict_with_error 

  # prefix with view_ is a db view can't update delete new
	has_many :view_sch_emps # can not use :dependent
	has_many :sch_emps
	has_many :view_sch_deps

	def assign_default_values
		# 請不要在此用會sql自己的語法，可能會無限回圈
		self.overwork_hours_for_freetax ||= 46
		self.days_per_month             ||= 30
		self.hours_per_day              ||= 8
		self.LP_rate                    ||= 6
		self.welfare_rate               ||= 0.5 
	end

	def create_environment
		# TODO 建立worktypes,department,overtypes...相關必要設定 
	end

end

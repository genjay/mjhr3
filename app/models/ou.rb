class Ou < ActiveRecord::Base
  store :settings, :accessors => [:sex, :url]
  validates :uid,:name, presence:true , uniqueness: {message: "已經被使用"} 

	after_initialize :assign_default_values
	after_create :create_environment
	has_many :worktypes, :dependent => :restrict_with_error
	has_many :workrests, :dependent => :restrict_with_error
	has_many :employees, :dependent => :restrict_with_error 
	has_many :overtypes, :dependent => :restrict_with_error
	has_many :departments, :dependent => :restrict_with_error 
	has_many :subsidies, :dependent => :restrict_with_error
	has_many :annual_leave_lists, :dependent => :restrict_with_error
	has_many :insurance_settings, :dependent => :restrict_with_error
	has_many :lvlists, :dependent => :restrict_with_error
	has_many :lvtypes, :dependent => :restrict_with_error
	has_many :offtypes, :dependent => :restrict_with_error
	has_many :pay_types, :dependent => :restrict_with_error
	has_many :doc_forgets, :dependent => :restrict_with_error
	has_many :doc_offworks, :dependent => :restrict_with_error
	has_many :doc_overworks, :dependent => :restrict_with_error
	has_many :calendars, :dependent => :restrict_with_error
	has_many :employee_insurance_settings, :dependent => :restrict_with_error
	has_many :employee_salary_settings, :dependent => :restrict_with_error
	has_many :employee_inoutlogs, :dependent => :restrict_with_error

  # prefix with view_ is a db view can't update delete new
	has_many :view_sch_emps # can not use :dependent
	has_many :sch_emps
	has_many :sch_deps
	has_many :view_sch_deps
	alias_method :viewschemps, :view_sch_emps

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

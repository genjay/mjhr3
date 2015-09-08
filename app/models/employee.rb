class Employee < ActiveRecord::Base
  validates :ou_id,:uid,:name, :arrive_date,presence:true 
 	validates :uid,:cardno, uniqueness: {scope: [:ou_id], message: "已經被使用" }, :allow_blank => true
  belongs_to :department,counter_cache: true  
  belongs_to :ou
  has_one :employee_insurance_setting
  has_many :employee_salary_settings
  has_many :employee_inoutlogs, dependent: :destroy
  has_many :view_sch_emps
  has_many :doc_forgets
  has_many :doc_overworks
  has_many :doc_offworks
  has_many :daily_duties  
  has_many :month_duties
  has_many :month_duty
  # has_many :calendars, foreign_key: :ou_id, primary_key: :ou_id
  # ,-> {"where calendars.duty_date >= employees.arrive_date and calendars.duty_date <= ifnull(employees.leave_date,'99991231')"}

  # def self.create
  # 	super
  #   self.employee_inoutlog.create(action:'hired')
  # end
  # def create
  # 	super
  # 	employee_inoutlog.create(employee_id:self,action:'hired')
  # end
  def to_s
    "#{self.uid} #{self.name}"
  end 

end

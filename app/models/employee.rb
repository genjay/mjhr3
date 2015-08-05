class Employee < ActiveRecord::Base
  validates :uid,:name,presence:true 
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

  # def self.create
  # 	super
  #   self.employee_inoutlog.create(action:'hired')
  # end
  # def create
  # 	super
  # 	employee_inoutlog.create(employee_id:self,action:'hired')
  # end
end

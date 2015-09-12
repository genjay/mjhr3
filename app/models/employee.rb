class Employee < ActiveRecord::Base
  validates :ou_id,:uid,:name, :arrive_date,presence:true 
 	validates :uid,:cardno, uniqueness: {scope: [:ou_id], message: "已經被使用" }, :allow_blank => true
  belongs_to :department#,counter_cache: true  
  belongs_to :ou
  has_one :employee_insurance_setting
  has_many :employee_salary_settings
  has_many :employee_inoutlogs, :dependent => :restrict_with_error
  has_many :view_sch_emps
  has_many :doc_forgets, :dependent => :restrict_with_error
  has_many :doc_overworks, :dependent => :restrict_with_error
  has_many :doc_offworks, :dependent => :restrict_with_error
  has_many :daily_duties , :dependent => :restrict_with_error 
  has_many :month_duties
  has_many :month_duty
  has_many :view_employee_inoutlogs
  after_create :create_inoutlog
  # has_many :calendars, foreign_key: :ou_id, primary_key: :ou_id
  # ,-> {"where calendars.duty_date >= employees.arrive_date and calendars.duty_date <= ifnull(employees.leave_date,'99991231')"}

  def create_inoutlog
    # 新增employee時，順便新增報到log(employee_inoutlogs)
    # 刪除暫時不寫，因為正常作業，不應該出現刪除人員的動作
    self.employee_inoutlogs.create(department_id:department_id,begin_at:arrive_date,ou_id:ou_id,action:'A1')
  end

  def to_s
    "#{self.uid} #{self.name}"
  end 

end

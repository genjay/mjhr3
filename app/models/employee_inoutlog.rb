class EmployeeInoutlog < ActiveRecord::Base
  validates :begin_at, format:{ with: Regexp_yyyymmdd,message: "日期格式錯誤"}
  belongs_to :employee
  belongs_to :department  
  # delegate :department, to: :employee
  validate :check_action, :check_dates
  after_save :update_employee
  after_initialize :assign_default_values

  before_destroy :can_delete?

  def assign_default_values
    self.begin_at ||= Date.today
    self.days_of_jobage ||= 0 
  end

  def update_employee
    case 
    when ['C1'].include?(action)
      then self.employee.update(department_id:department_id)
    when ['A1','A2'].include?(action)
      then self.employee.update(arrive_date:begin_at,leave_date:nil)
    when ['Q1','Q2'].include?(action)
      then self.employee.update(leave_date:begin_at)
    end
  end

  def can_delete?
    #最後一筆才能刪除,
    last_row = self.get_last #class.where(employee_id:employee_id).order("begin_at DESC,id desc").first
    (last_row.id==self.id)? true:false
  end

  def check_dates
    if get_last
      errors.add(:begin_at,"生效日不可小於(#{get_last.begin_at})") if begin_at < get_last.begin_at
    end
  end

  def check_action
    if get_last
      errors.add(:action,"選項錯誤，依規則你只能選#{goto_action}") unless goto_action.include?(self.action) 
    end
  end

  def goto_action
    # 用該員工的最後一筆(EmployeeInoulog)，來抓可以使用的 action
    if get_last
      last_row = get_last
      t = Option.find_by(model_title:self.class,key:last_row.action) 
      return t.status_rule
    end
  end

  def get_last   
   # 生效日(可能同一日會有二筆，所以order要注意)
    log.order(:begin_at => :desc,:id => :desc).first 
  end

  def log   
    EmployeeInoutlog.where(employee_id:employee_id) 
  end
end

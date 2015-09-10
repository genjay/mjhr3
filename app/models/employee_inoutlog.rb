class EmployeeInoutlog < ActiveRecord::Base
  belongs_to :employee
  belongs_to :department
  # delegate :department, to: :employee

  before_destroy :can_delete?

  def self.check_permit(empid) 
    self.select("action, begin_at").where("employee_id = #{empid}").order("created_at DESC").first
  end

  def can_delete?
    delete = self.class.where(:employee_id => employee_id).order("begin_at DESC").first
    if delete != nil and delete.id == id.to_i
      true
    else
      false
    end
  end
end

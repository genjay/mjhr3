class EmployeeInoutlog < ActiveRecord::Base
  belongs_to :employee

  delegate :department, to: :employee

  def self.check_permit(empid) 
    self.select("action, begin_at").where("employee_id = #{empid}").order("created_at DESC").first
  end
end

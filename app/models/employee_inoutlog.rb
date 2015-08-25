class EmployeeInoutlog < ActiveRecord::Base
  belongs_to :employee

  delegate :department, to: :employee

  def self.check_permit(empid) 
    self.select("action").where("employee_id = #{empid}").order("created_at DESC").first
  end

  def self.set_options
    return options = {"A1"=>"報到", "A2"=>"離職", "A3"=>"調職", "A4"=>"留停", "A5"=>"復職"}
  end
end

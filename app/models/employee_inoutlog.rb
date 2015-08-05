class EmployeeInoutlog < ActiveRecord::Base
  belongs_to :employee

  delegate :department, to: :employee
end

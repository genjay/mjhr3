class SchDep < ActiveRecord::Base
  validates :department_id, :duty_date, uniqueness: {scope: [:department_id, :duty_date]}
end

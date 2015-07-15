class SchEmp < ActiveRecord::Base
	 # validates :employee_id, :duty_date, uniqueness: {scope: [:employee_id, :duty_date]}
end

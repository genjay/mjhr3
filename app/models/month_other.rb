class MonthOther < ActiveRecord::Base
	belongs_to :employee
	belongs_to :pay_type
	
end

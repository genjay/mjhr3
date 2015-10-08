class MonthOtherDetail < ActiveRecord::Base
	belongs_to :month_other
	belongs_to :employee
end

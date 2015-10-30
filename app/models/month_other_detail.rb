class MonthOtherDetail < ActiveRecord::Base
	require "csv"

	belongs_to :month_other
	belongs_to :employee

	def self.import(file, id)
    		CSV.foreach(file.path, headers: true) do |row|
		      detail_hash = row.to_hash
		      employee = Employee.find_by(uid:  detail_hash["employee_uid"])

		      if employee != nil
		      		detail_hash["employee_id"] = employee.id
			      	detail_hash["month_other_id"] = id
			      	detail_hash.delete("employee_uid")
		      		detail = MonthOtherDetail.where(month_other_id: id, employee_id: employee.id)
		      		if detail.count == 0			      		
			      		MonthOtherDetail.create!(detail_hash)
		      		else
		      			detail.first.update_attributes(detail_hash)
		      		end
		      	else
		      		return false
		      	end
	      end
	      return true
	 end

end

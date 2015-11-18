class MonthOtherDetail < ActiveRecord::Base

	belongs_to :month_other
	belongs_to :employee

	def self.find_details(id)
		self.where("month_other_id = ?", id).order("employee_id ASC")
	end

	def self.import(file, id)
		MonthOtherDetail.destroy_all(month_other_id: id)

		Spreadsheet.client_encoding = 'UTF-8'
    		book = Spreadsheet.open file.path
    		sheet1 = book.worksheet 0
		sheet1.each do |row|
			detail_hash = {"employee_uid" => row[0], "amt" => row[1]}
			employee = Employee.find_by(uid:  detail_hash["employee_uid"])

			if employee != nil
		      		detail_hash["employee_id"] = employee.id
			      	detail_hash["month_other_id"] = id
			      	detail_hash.delete("employee_uid")
		      		# detail = MonthOtherDetail.where(month_other_id: id, employee_id: employee.id)
		      		# if detail.count == 0			      		
			      	MonthOtherDetail.create!(detail_hash)
		      		# else
		      		# 	detail.first.update_attributes(detail_hash)
		      		# end
		      	else
		      		return false
		      	end
	       end
	       return true
	end

end

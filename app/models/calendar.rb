class Calendar < ActiveRecord::Base
	validates :duty_date, uniqueness: {scope: [:ou_id]} 
	after_initialize :assign_default_values

	def self.create_by_yyyymm(ou_id,yyyymm)
		if yyyymm.to_s.match(Regexp_yyyymm)
			date_start = "#{yyyymm}01".to_date
			date_end = date_start.end_of_month
			if self.where("ou_id=? and duty_date between ? and ?",ou_id,date_start,date_end).size < 31
				(date_start..date_end).each do |i|
					self.create(ou_id:ou_id,duty_date:i)
				end
			end
		else
			puts "yyyymm 錯誤"
			return false
	  end
	end
  
  def assign_default_values
  	self.is_holiday ||= (duty_date.to_s.to_date.cwday==[6,7]) ? 1:0
  end

	def self.search(ou_id,yyyymm)
		if yyyymm.to_s.match(Regexp_yyyymm)
			date_start = "#{yyyymm}01".to_date
			date_end = date_start.end_of_month
		  self.where("ou_id= ? and duty_date between ? and ?",ou_id,date_start,date_end)
		end  
	end
	

end
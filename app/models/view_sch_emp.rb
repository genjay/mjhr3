class ViewSchEmp < ActiveRecord::Base
  # default_scope { order :uid, :duty_date }
  default_scope { limit 31  }  

  self.primary_key = 'id'
  #因為這是用 calendar 動態產生筆數 行事曆* 人數
  #所以限制一次最多 31筆
	# protected

	def self.search(a,b)
		self.where("duty_date between #{a}01 and #{a}31 and uid = '#{b}'")\
		.order(:uid, :duty_date) 
	end

	def save 
		if self.id == 0 
		  x = SchEmp.new()
	  else
	  	x = SchEmp.find(self.id)
	  end
		x.ou_id = self.id
		x.employee_id = self.employee_id
		x.duty_date = self.duty_date
		x.worktype_id = self.worktype_id
		x.is_holiday = self.is_holiday

    x.save
	end

	# def readonly?
	# 	true
	# end
end

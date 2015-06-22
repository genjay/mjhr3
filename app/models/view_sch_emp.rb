class ViewSchEmp < ActiveRecord::Base
  default_scope { order :duty_date }
  default_scope { limit 31  } 
  
	belongs_to :ou

  self.primary_key = 'id'
  #因為這是用 calendar 動態產生筆數 行事曆* 人數
  #所以限制一次最多 31筆
	# protected
	def self.search_ym(yyyymm)
		self.where("duty_date >= #{yyyymm}*100")
	end

	def self.search_emp_id(emp_id)
		self.where(uid: emp_id)
	end

	def self.search(a,b)
		self.where("duty_date between #{a}01 and #{a}31 and uid = '#{b}'")
	end

	def readonly?
		true
	end
end

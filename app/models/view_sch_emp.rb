class ViewSchEmp < ActiveRecord::Base
  validates :employee_id, :duty_date, uniqueness: {scope: [:employee_id, :duty_date]}
  default_scope { limit 31  }  

  belongs_to :worktype
  self.primary_key = 'id' # 這行一定要加，因為這是db view，沒有primary index,給rails 抓預設值

	def self.search(a,b)
		self.where("duty_date between #{a}01 and #{a}31 and uid = '#{b}'")\
		.order(:uid, :duty_date) 
	end

	def destroy
		if self.id == 0 
			errors[:message] << "This isn't a real data,it a db view"
			false
		else
			SchEmp.destroy(self.id)
		end
	end

	def save 
	  sch = SchEmp.column_names
	  if self.id == 0 
	    x = SchEmp.new()
	  else
	  	x = SchEmp.find(self.id)
	  end
	  x.update_attributes(self.attributes.slice(*sch))
	  v = ViewSchEmp.find_by(employee_id: employee_id,duty_date: duty_date).attributes
	  self.assign_attributes(v)
	end

	# def readonly?
	# 	true
	# end
end

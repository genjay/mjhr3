class ViewSchDep < ActiveRecord::Base
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
			errors[:message] << "Can't not delete,it a db view"
			false
		else
			SchDep.destroy(self.id)
		end
	end

	def save 
	  sch = SchDep.column_names
	  if self.id == 0 
	    x = SchDep.new()
	  else
	  	x = SchDep.find(self.id)
	  end
	  x.update_attributes(self.attributes.slice(*sch))
	  v = ViewSchDep.find_by(department_id: department_id,duty_date: duty_date).attributes
	  self.assign_attributes(v)
	end


	# def readonly?
	# 	true
	# end
end

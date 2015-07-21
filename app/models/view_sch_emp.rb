class ViewSchEmp < ActiveRecord::Base
	validates :is_holiday, :worktype_id ,presence: true
  # default_scope { limit 31  }  
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

	def readonly?
		true
	end
end

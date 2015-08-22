class Calendar < ActiveRecord::Base
	# validates :is_holiday, :worktype_id ,presence: true
	validates :duty_date, uniqueness: {scope: [:ou_id]} 
 #  belongs_to :worktype
  # self.primary_key = 'id' # 這行一定要加，因為這是db view，沒有primary index,給rails 抓預設值
  self.primary_key = 'duty_date'
  has_many :dutys,-> {where leave_date:nil},class_name: Employee,foreign_key: :ou_id,primary_key: :ou_id
	after_initialize :assign_default_values
  
  def assign_default_values
  	self.is_holiday ||= 0  
  end

	def self.search(a)
		self.where("duty_date between #{a}01 and #{a}31")\
		.order(:duty_date) 
	end

	def destroy
		if self.id == 0 
			errors[:message] << "This isn't a real data,it a db view"
			false
		else
			Calendar.destroy(self.id)
		end
	end

end
class Overtype < ActiveRecord::Base

  validates :uid,:name,presence:true 
 	validates :uid,:name, uniqueness: { scope: :ou_id	,
    message: "已經被使用" } 
  # default_scope (aa) { where ("ou_id = ?"),aa }
  scope :ou,->(aa) { where ("ou_id = #{aa}") }


	after_initialize :defaults 
	def defaults
		# 請不要在此用會sql自己的語法，可能會無限回圈
		self.mins_of_A ||= 120
		self.mins_of_B ||= 120
		self.rate_of_A ||= 1.3333
		self.rate_of_B ||= 1.6666
		self.rate_of_C ||= 2.0000
		self.rate_of_H ||= 2.0000
		self.amt_of_A  ||= 0
		self.amt_of_B  ||= 0
		self.amt_of_C  ||= 0
		self.amt_of_H  ||= 0 
		self.mins_per_unit ||= 60 
	end

  def destroy
	  case 
	  when false # 範例 Department.exists?(upper_id: self.id)
	    then 
	      self.errors.add :base, "using [#{self.uid+self.name}] can't delete"
	      false 
	  else
	    super
	  end 
  end
end

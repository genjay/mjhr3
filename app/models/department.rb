class Department < ActiveRecord::Base

	# default_scope { where(id: nil)}
  belongs_to :worktype
  belongs_to :upper, class_name: "Department"
  validates :uid,:name,presence:true 
 	validates :uid,:name, uniqueness: { scope: :ou_id	,
    message: "已經被使用" }

  
  before_destroy :check_for_destory
  def check_for_destory
  end
  after_initialize :defaults 

  def defaults
  	self.worktype = Worktype.where(ou_id:self.ou_id).first
  end
end

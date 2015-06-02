class Department < ActiveRecord::Base
  belongs_to :worktype
  belongs_to :upper, class_name: "Department"
  validates :uid,:name,presence:true 
 	validates :uid,:name, uniqueness: { scope: :ou_id	,
    message: "已經被使用" }

  
  before_destroy :check_for_destory
  def check_for_destory
  end
end

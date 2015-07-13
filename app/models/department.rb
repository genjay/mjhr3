class Department < ActiveRecord::Base
  belongs_to :worktype
  belongs_to :upper, class_name: "Department" 
  has_many :employees, :dependent => :restrict_with_error

  validates :ou_id, presence: true
  validates :uid,:name, presence: true, uniqueness: { scope: :ou_id ,
    message: "已經被使用" }  


  # after_initialize :defaults 

  # def defaults
  #   if worktype_id == nil
  # 	  self.worktype = Worktype.where(ou_id:self.ou_id).first
  #   end
  # end
end

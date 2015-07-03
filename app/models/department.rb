class Department < ActiveRecord::Base

	# default_scope { where(id: nil)}
  belongs_to :worktype
  belongs_to :upper, class_name: "Department"
  validates :uid,:name,presence:true 
 	validates :uid,:name, uniqueness: { scope: :ou_id	,
    message: "已經被使用" }


  def destroy
    case 
    when Department.exists?(upper_id: self.id)
      then 
        self.errors.add :base, "Department using #{self.uid} can't delete"
        false
    when Employee.exists?(department_id: self.id)
      then 
        self.errors.add :base, "Employee using can't delete"
        # errors.add "Employee using can't delete"
        false
    else
      super
    end 
  end
 

  # after_initialize :defaults 

  # def defaults
  #   if worktype_id == nil
  # 	  self.worktype = Worktype.where(ou_id:self.ou_id).first
  #   end
  # end
end

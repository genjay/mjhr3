class Department < ActiveRecord::Base
  belongs_to :worktype
  belongs_to :upper, class_name: "Department" 
  belongs_to :ou
# condition , -> { where active: true }
  has_many :employees, -> {where ou_id: 1}, :dependent => :restrict_with_error
  has_many :departments,-> {where ou_id: 1}, class_name: "Department", foreign_key: "id", :dependent => :restrict_with_error

  validates :ou_id, presence: true
  validates :uid,:name, presence: true, uniqueness: {scope: :ou_id, message: "已經被使用"}  
  validate :check_list

  def check_list
    # 檢查下拉的預設值，User 可以用瀏覽器的檢查元素，修改下拉的預設值，並送出
    worklist = Worktype.where(ou_id:ou_id).to_a.<< nil
    errors.add(:worktype,'別亂玩') unless worklist.include? self.worktype 
    deplist = Department.where(ou_id:ou_id).to_a.<< nil
    errors.add(:upper,'別亂玩') unless deplist.include? self.upper 
  end

  def to_s
    "#{uid} #{name}"
  end

end

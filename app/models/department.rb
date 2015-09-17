class Department < ActiveRecord::Base
  belongs_to :worktype
  belongs_to :upper, class_name: "Department" 
  belongs_to :ou
# condition , -> { where active: true }
  has_many :employees, -> {where ou_id: 1}, :dependent => :restrict_with_error
  has_many :departments,-> {where ou_id: 1}, class_name: "Department", foreign_key: "id", :dependent => :restrict_with_error

  validates :ou_id, presence: true
  validates :uid,:name, presence: true, uniqueness: {scope: :ou_id, message: "已經被使用"}  

  def to_s
    "#{uid} #{name}"
  end

end

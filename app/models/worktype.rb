class Worktype < ActiveRecord::Base
  validates :uid,:name,presence:true 
  validates :uid, uniqueness: {scope: :ou_id, message: "已經被使用"} 

  has_many :workrests, :dependent => :destroy
  has_many :departments, :dependent => :restrict_with_error 
  has_many :sch_deps, :dependent => :restrict_with_error
  has_many :sch_emps, :dependent => :restrict_with_error
  belongs_to :ou

  accepts_nested_attributes_for :workrests, :allow_destroy => true

  after_initialize :assign_default_values

  def assign_default_values
    self.on_duty_at               ||= '08:20'
    self.off_duty_at              ||= '17:20'
    self.buffer_before_duty       ||= 0
    self.buffer_after_duty        ||= 0
    self.minimum_before_overwork  ||= 60
    self.minimum_after_overwork   ||= 120
    self.minimum_holiday_overwork ||= 120
    self.range_on                 ||= 360
    self.range_off                ||= 480
    self.mins_of_duty             ||= 480
  end
end

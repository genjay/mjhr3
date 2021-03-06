class Worktype < ActiveRecord::Base
  validates :uid,:name,presence:true 
  validates :uid, uniqueness: {scope: :ou_id, message: "已經被使用"} 
  validates :buffer_before_duty,:buffer_after_duty,:minimum_before_overwork,:minimum_after_overwork,:minimum_holiday_overwork,:range_on,:range_off,:mins_of_duty,:numericality => { :greater_than_or_equal_to => 0 }

  has_many :workrests, :dependent => :destroy
  has_many :departments, :dependent => :restrict_with_error 
  has_many :sch_deps, :dependent => :restrict_with_error
  has_many :sch_emps, :dependent => :restrict_with_error
  belongs_to :ou

  accepts_nested_attributes_for :workrests, :allow_destroy => true

  after_initialize :assign_default_values
  before_validation :some_values_upcase

  def some_values_upcase
    self.uid.replace uid.upcase
  end

  def assign_default_values
    # TODO 若 x=Worktype.select(:uid) 
    # 會出現 ActiveModel::MissingAttributeError: missing attribute: on_duty_at
    # 暫時不知怎麼解較好，暫時不要用select，此表暫時不會有效能的問題才是
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
  
  def to_s
    "#{uid} #{name}"
  end
end

class Workrest < ActiveRecord::Base
  validates :rest_begin_at, :mins_of_rest, presence:true
  validates :rest_begin_at, uniqueness: { scope: [:worktype_id,:is_holiday], message: "已經被使用" }

  belongs_to :worktype 
end

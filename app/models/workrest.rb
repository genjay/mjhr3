class Workrest < ActiveRecord::Base
  validates :rest_begin_at, :mins_of_rest, presence:true

  belongs_to :worktype 
end

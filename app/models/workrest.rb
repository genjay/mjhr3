class Workrest < ActiveRecord::Base
  belongs_to :worktype, :dependent => :destroy
end

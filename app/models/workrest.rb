class Workrest < ActiveRecord::Base
	default_scope { where("ou_id is null")}
  belongs_to :worktype, :dependent => :destroy
end

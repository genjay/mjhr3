class AnnualLeaveList < ActiveRecord::Base
	default_scope { where("ou_id is null")}
end

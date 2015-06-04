class PayType < ActiveRecord::Base
	default_scope { where("ou_id is null")}
  validates :uid,:name,:cycle_unit,:rule_for_break,presence:true 
 	validates :uid,:name, uniqueness: { scope: :ou_id	,
    message: "已經被使用" } 
end

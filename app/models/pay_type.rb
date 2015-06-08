class PayType < ActiveRecord::Base
  validates :uid,:name,:cycle_unit,:rule_for_break,presence:true 
 	validates :uid,:name, uniqueness: { scope: :ou_id	,
    message: "已經被使用" } 
  # belongs_to :cycle_unit, class_name: "Catcode", foreign_key: "cycle_unit",where {}
end

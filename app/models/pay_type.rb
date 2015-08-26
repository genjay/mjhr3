class PayType < ActiveRecord::Base
  validates :uid,:name,:cycle_unit,:rule_for_break,presence:true 
 	validates :uid,:name, uniqueness: { scope: :ou_id	,
    message: "已經被使用" } 
  # belongs_to :cycle_unit, class_name: "Catcode", foreign_key: "cycle_unit",where {}
  def self.cycle_options
    arr = [["A 月薪", "A"], ["B 時薪", "B"], ["C 日薪", "C"]]
  end

  def self.rule_options
  	arr = [["A 依出勤比率", "A"], ["B 全給付", "B"], ["C 手動輸入", "C"]]
  end
end

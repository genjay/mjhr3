class Employee < ActiveRecord::Base
  validates :uid,:name,presence:true 
 	validates :uid,:cardno_of_duty, uniqueness: { scope: [:ou_id]	,
    message: "已經被使用" } 
  belongs_to :department
  has_one :employee_insurance_setting
end

require 'test_helper'

class MonthDutyTest < ActiveSupport::TestCase
	test "結轉 參數要能吃 date/integer/string" do
		d_fr,d_to = 20150126,20150228
		MonthDuty.d04(100,201502,d_fr,d_to) 
		d_fr = d_fr.to_s.to_date
		d_to = d_to.to_s.to_date
		MonthDuty.d04(100,201502,d_fr,d_to) 

	end
	test "結轉 20150126..20150228" do  
		# 好象 d04，越過ActiveRecord 直接用 sql
		# 在此 daily_duties資料會多算
		# d_fr = '20150126'.to_date
		# d_to = '20150228'.to_date
		# a01 = Employee.find_by(ou_id:100,uid:'a01')
		# a02 = Employee.find_by(ou_id:100,uid:'a02')
		# a01.update(arrive_date:20150101,leave_date:20150131)
		# a02.update(arrive_date:20150101,leave_date:nil)
		# # DailyDuty.d04(100,d_fr..d_to)
		# MonthDuty.d04(100,201502,20150126,20150228)
		# assert_equal 6,a01.month_duties[0].dutydays
		# assert_equal 33,a02.month_duties[0].dutydays
	end

end

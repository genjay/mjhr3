require 'test_helper'

class MonthSalaryTest < ActiveSupport::TestCase
	test "出勤日<30 時以出勤日數計算，出勤日>30 時，以整月計算" do  
		a01 = Employee.find_by(ou_id:100,uid:'a01')
		a02 = Employee.find_by(ou_id:100,uid:'a02')
		a03 = Employee.find_by(ou_id:100,uid:'a03')
		# EmployeeSalarySetting.where(ou_id:100).delete_all 
		p01 = PayType.find_by(ou_id:100,uid:'A01')
		a01.employee_salary_settings.create(ou_id:100,pay_type: p01,amt:30000)
		a02.employee_salary_settings.create(ou_id:100,pay_type: p01,amt:30000)
		a03.employee_salary_settings.create(ou_id:100,pay_type: p01,amt:30000)
		range = '20150126'.to_date..'20150228'.to_date
		# DailyDuty.d04(100,range)
		# MonthDuty.d04(100,201502,20150126,20150228)
		MonthSalary.d04(100,201502)
		s01 = MonthSalary.find_by(pay_type_id: p01.id,employee_id: a01.id,yyyymm:201502)
		s02 = MonthSalary.find_by(pay_type_id: p01.id,employee_id: a02.id,yyyymm:201502)
		assert_equal 6000,s01.amt
		assert_equal 30000,s02.amt
	end

	test "全給付津貼" do
		a01 = Employee.find_by(ou_id:100,uid:'A01')
		p03 = PayType.find_by(ou_id:100,uid:'A03')
		p04 = PayType.find_by(ou_id:100,uid:'A04')
		a01.employee_salary_settings.create(ou_id:100,pay_type: p03,amt:3000)
		a01.employee_salary_settings.create(ou_id:100,pay_type: p04,amt:3000)
		MonthSalary.d04(100,201502)

	end
end
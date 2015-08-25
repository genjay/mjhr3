require 'test_helper'

class DailyDutyTest < ActiveSupport::TestCase

  test "到職前，不應該出現資料" do
  	a01 = Employee.find_by(uid:'a01',ou_id: 100)
  	a01.update(arrive_date: 20150205)
    range = 20150201..20150205
  	DailyDuty.d04(100,range)
  	assert_equal 1,a01.daily_duties.where(duty_date:range).size
  end

  test '離職後，不應該出現資料' do
  	a01 = Employee.find_by(uid:'a01',ou_id: 100)
  	a01.update(arrive_date: 20150205,leave_date: 20150210)
    range = 20150201..20150228
  	DailyDuty.d04(100,range)
  	assert_equal 6,a01.daily_duties.where(duty_date:range).size
  end
		 
end
require 'test_helper'

class CalendarTest < ActiveSupport::TestCase
	test "is_holiday can't be nil " do 
		a = Calendar.create(ou_id:1,duty_date:20150705)
		a = Calendar.find_by(ou_id:1,duty_date:20150705)
		assert_not_equal nil,a.is_holiday
	end

	test "is_holiday input 0, must save false" do
		a = Calendar.create(ou_id:1, duty_date: 20150707,is_holiday:0)
		a = Calendar.find_by(ou_id:1,duty_date: 20150707)
		assert_equal false,a.is_holiday
	end

	test "is_holiday input 1, must save true" do
		a = Calendar.create(ou_id:1, duty_date: 20150707,is_holiday:1)
		a = Calendar.find_by(ou_id:1,duty_date: 20150707)
		assert_equal true,a.is_holiday
	end

	test "can not have two duty_date in the same ou" do
		Calendar.create(ou_id:2, duty_date:20150709)
		Calendar.create(ou_id:2, duty_date:20150709)
		a = Calendar.where(ou_id:2, duty_date: 20150709).count
		assert_equal 1, a
	end

	test "different ou can add the same duty_date" do
		Calendar.create(ou_id:8, duty_date: 20150701)
		Calendar.create(ou_id:9, duty_date: 20150701)
		cnt = Calendar.where(duty_date: 20150701,ou_id: [8,9]).count
		assert_equal 2,cnt
	end

end
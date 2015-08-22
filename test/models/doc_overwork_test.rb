require 'test_helper'

class DocOverworkTest < ActiveSupport::TestCase
	# 前置作業
	# 需要 Calendar, Employee 才能有 ViewSchEmp
 
	test "平日加班單輸入hr=6，要拆成 2/2/2" do
		self.init_data
		o = DocOverwork.create(ou_id:1,employee_id: 123,duty_date:20150711,hr:5)
	end

	test "同一日不能輸入二筆加班單" do
		self.init_data
		o = DocOverwork.create(ou_id:1,employee_id: 123,duty_date:20150711,hr:5)
		assert_equal 0,o.errors.size
		o = DocOverwork.create(ou_id:1,employee_id: 123,duty_date:20150711,hr:5)
    assert_not_equal 0,o.errors.size
	end

	def init_data
  	w = Worktype.create(ou_id:1,uid: 'a',name: 'name_2')
  	assert_equal 0,w.errors.size
  	c = Calendar.create(ou_id:1,duty_date:20150711,is_holiday:1)
  	assert_equal 0,c.errors.size
  	e = Employee.create(id:123,ou_id:1,uid:'001',name:'001',arrive_date:20150101)
    assert_equal 0, e.errors.size
	end

end 
 
require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase

  test "Some columns must has value " do
    h_ok = {ou_id: 11,uid:'001',name:'001'}
    h_ng = {arrive_date: nil}
    a = Employee.create(h_ok.merge(h_ng))
    assert_equal h_ng.size, a.errors.size
  end

  test "In the some ou_id cann't has two man use the some cardno" do
  	a = Employee.create(arrive_date:20150701,uid:'a01',name:'a01',ou_id:1,cardno:'a01')
  	assert_equal true,a.errors.size == 0 
  	b = Employee.create(arrive_date:20150701,uid:'a02',name:'a02',ou_id:1,cardno:'a01')
  	assert_equal false,b.errors.size == 0 
  end
end

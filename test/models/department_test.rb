require 'test_helper'

class DepartmentTest < ActiveSupport::TestCase
  test "Without ou_id can't created " do
    a = Department.create(uid:'100',name:'總經理室')
  	assert_equal false,a.valid?
  end

  test "In different ou_id it can has the same uid" do
  	a = Department.create(uid:'101',name:'101',ou_id:1)
  	assert_equal true, a.errors.size == 0
  	b = Department.create(uid:'101',name:'101',ou_id:2)
  	assert_equal true, b.errors.size == 0
  	c = Department.create(uid:'101',name:'101',ou_id:1)
    assert_equal true, c.errors.size > 0

  end


end

require 'test_helper'

class WorktypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Can't not has the same uid in the some ou_id" do
  	a = Worktype.create(ou_id:1,uid: 'a',name:'name_a')
  	assert_equal true, a.errors.size == 0
  	a = Worktype.find a.id 
  	assert_equal 'A', a.uid 
  	b = Worktype.create(ou_id:1,uid: 'a',name: 'name_2')
  	assert_equal false, b.errors.size == 0 
  end

  test "Some columns values must >= 0 " do
  	hash_ok = {ou_id:2, uid: 'b',name: 'name_b'}
  	hash_ng = {buffer_before_duty: -1,buffer_after_duty: -1,minimum_before_overwork: -1,minimum_after_overwork:-1,minimum_holiday_overwork:-1,range_on:-1,range_off:-1,mins_of_duty:-1}
  	h = hash_ok.merge(hash_ng)
  	a = Worktype.create h
  	assert_equal true, a.errors.size == hash_ng.size

  end
end

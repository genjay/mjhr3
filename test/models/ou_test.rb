require 'test_helper'

class OuTest < ActiveSupport::TestCase
  test "Normal create and assign default values" do
  	a = Ou.create(uid:'16130535',name:'name Of 16130535')
  	assert true,a.valid?
  	# 因為資料庫格式有機會，讓存檔後的值不同，所以create後在find_by判斷
  	a = Ou.find_by(uid: a.uid)
  	assert_equal '16130535', a.uid
  	assert_equal 46,a.overwork_hours_for_freetax
  	assert_equal 8,a.hours_per_day
  	assert_equal 30,a.days_per_month
  	assert_equal 6,a.LP_rate
  	assert_equal 0.5,a.welfare_rate
  end

  test 'unique of uid ' do
  	ou_ok = Ou.create(uid:'1111',name:'aa')
  	ou_ng = Ou.create(uid:ou_ok.uid)

  	assert ou_ok.valid?
  	assert_not ou_ng.valid?
  end

end

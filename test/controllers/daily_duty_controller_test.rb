require 'test_helper'

class DailyDutyControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get cal" do
    get :cal
    assert_response :success
  end

end

require 'test_helper'

class AnnualLeaveListsControllerTest < ActionController::TestCase
  setup do
    @annual_leave_list = annual_leave_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:annual_leave_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create annual_leave_list" do
    assert_difference('AnnualLeaveList.count') do
      post :create, annual_leave_list: { days: @annual_leave_list.days, memo: @annual_leave_list.memo, months_of_job: @annual_leave_list.months_of_job, ou_id: @annual_leave_list.ou_id }
    end

    assert_redirected_to annual_leave_list_path(assigns(:annual_leave_list))
  end

  test "should show annual_leave_list" do
    get :show, id: @annual_leave_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @annual_leave_list
    assert_response :success
  end

  test "should update annual_leave_list" do
    patch :update, id: @annual_leave_list, annual_leave_list: { days: @annual_leave_list.days, memo: @annual_leave_list.memo, months_of_job: @annual_leave_list.months_of_job, ou_id: @annual_leave_list.ou_id }
    assert_redirected_to annual_leave_list_path(assigns(:annual_leave_list))
  end

  test "should destroy annual_leave_list" do
    assert_difference('AnnualLeaveList.count', -1) do
      delete :destroy, id: @annual_leave_list
    end

    assert_redirected_to annual_leave_lists_path
  end
end

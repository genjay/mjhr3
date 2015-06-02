require 'test_helper'

class WorktypesControllerTest < ActionController::TestCase
  setup do
    @worktype = worktypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:worktypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create worktype" do
    assert_difference('Worktype.count') do
      post :create, worktype: { buffer_after_duty: @worktype.buffer_after_duty, buffer_before_duty: @worktype.buffer_before_duty, is_stoped: @worktype.is_stoped, memo: @worktype.memo, minimum_after_overwork: @worktype.minimum_after_overwork, minimum_before_overwork: @worktype.minimum_before_overwork, minimum_holiday_overwork: @worktype.minimum_holiday_overwork, mins_of_duty: @worktype.mins_of_duty, name: @worktype.name, off_duty_at: @worktype.off_duty_at, on_duty_at: @worktype.on_duty_at, ou_id: @worktype.ou_id, range_off: @worktype.range_off, range_on: @worktype.range_on, uid: @worktype.uid }
    end

    assert_redirected_to worktype_path(assigns(:worktype))
  end

  test "should show worktype" do
    get :show, id: @worktype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @worktype
    assert_response :success
  end

  test "should update worktype" do
    patch :update, id: @worktype, worktype: { buffer_after_duty: @worktype.buffer_after_duty, buffer_before_duty: @worktype.buffer_before_duty, is_stoped: @worktype.is_stoped, memo: @worktype.memo, minimum_after_overwork: @worktype.minimum_after_overwork, minimum_before_overwork: @worktype.minimum_before_overwork, minimum_holiday_overwork: @worktype.minimum_holiday_overwork, mins_of_duty: @worktype.mins_of_duty, name: @worktype.name, off_duty_at: @worktype.off_duty_at, on_duty_at: @worktype.on_duty_at, ou_id: @worktype.ou_id, range_off: @worktype.range_off, range_on: @worktype.range_on, uid: @worktype.uid }
    assert_redirected_to worktype_path(assigns(:worktype))
  end

  test "should destroy worktype" do
    assert_difference('Worktype.count', -1) do
      delete :destroy, id: @worktype
    end

    assert_redirected_to worktypes_path
  end
end

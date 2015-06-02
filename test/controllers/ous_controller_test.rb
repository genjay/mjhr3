require 'test_helper'

class OusControllerTest < ActionController::TestCase
  setup do
    @ou = ous(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ous)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ou" do
    assert_difference('Ou.count') do
      post :create, ou: { LP_rate: @ou.LP_rate, days_per_month: @ou.days_per_month, hours_per_day: @ou.hours_per_day, memo: @ou.memo, name: @ou.name, overwork_hours_for_freetax: @ou.overwork_hours_for_freetax, uid: @ou.uid, welfare_rate: @ou.welfare_rate }
    end

    assert_redirected_to ou_path(assigns(:ou))
  end

  test "should show ou" do
    get :show, id: @ou
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ou
    assert_response :success
  end

  test "should update ou" do
    patch :update, id: @ou, ou: { LP_rate: @ou.LP_rate, days_per_month: @ou.days_per_month, hours_per_day: @ou.hours_per_day, memo: @ou.memo, name: @ou.name, overwork_hours_for_freetax: @ou.overwork_hours_for_freetax, uid: @ou.uid, welfare_rate: @ou.welfare_rate }
    assert_redirected_to ou_path(assigns(:ou))
  end

  test "should destroy ou" do
    assert_difference('Ou.count', -1) do
      delete :destroy, id: @ou
    end

    assert_redirected_to ous_path
  end
end

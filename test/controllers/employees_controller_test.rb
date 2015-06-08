require 'test_helper'

class EmployeesControllerTest < ActionController::TestCase
  setup do
    @employee = employees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:employees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create employee" do
    assert_difference('Employee.count') do
      post :create, employee: { address1: @employee.address1, address2: @employee.address2, arrive_date: @employee.arrive_date, birthday: @employee.birthday, cardno_of_duty: @employee.cardno_of_duty, department_id: @employee.department_id, education: @employee.education, email: @employee.email, id_number: @employee.id_number, levae_date: @employee.levae_date, marriage: @employee.marriage, name: @employee.name, school: @employee.school, sex: @employee.sex, tel1: @employee.tel1, tel2: @employee.tel2, uid: @employee.uid }
    end

    assert_redirected_to employee_path(assigns(:employee))
  end

  test "should show employee" do
    get :show, id: @employee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @employee
    assert_response :success
  end

  test "should update employee" do
    patch :update, id: @employee, employee: { address1: @employee.address1, address2: @employee.address2, arrive_date: @employee.arrive_date, birthday: @employee.birthday, cardno_of_duty: @employee.cardno_of_duty, department_id: @employee.department_id, education: @employee.education, email: @employee.email, id_number: @employee.id_number, levae_date: @employee.levae_date, marriage: @employee.marriage, name: @employee.name, school: @employee.school, sex: @employee.sex, tel1: @employee.tel1, tel2: @employee.tel2, uid: @employee.uid }
    assert_redirected_to employee_path(assigns(:employee))
  end

  test "should destroy employee" do
    assert_difference('Employee.count', -1) do
      delete :destroy, id: @employee
    end

    assert_redirected_to employees_path
  end
end

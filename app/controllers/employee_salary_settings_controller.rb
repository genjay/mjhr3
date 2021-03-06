class EmployeeSalarySettingsController < ApplicationController
  before_action :set_employee  
  before_action :set_employee_salary, only: [:edit, :update]

  def index
    @employee_salaries = @employee.employee_salary_settings.includes([:pay_type]) 
  end

  def new
    @employee_salary = @employee.employee_salary_settings.new
  end

  def create
    @employee_salary = @employee.employee_salary_settings.new(employee_salary_params)
    respond_to do |format|
      if @employee_salary.save
        format.html { redirect_to employee_employee_salary_settings_path, notice: '員工薪資設定新增成功' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @employee_salary.update(employee_salary_params)
        format.html { redirect_to employee_employee_salary_settings_path, notice: '員工薪資設定修改成功' }
      else
        format.html { render :edit }
      end
    end
  end

  def multi_destroy
    items = params[:ids]
    case items
    when nil
      redirect_to employee_employee_salary_settings_path, :flash => { :alert => "沒有項目被選取" }
    else
      err_msg,ok_msg,all_msg = '','',''
      params[:ids].each do |f|
        x = current_ou.employee_salary_settings.find(f)
        if x.destroy
          ok_msg = ok_msg << "[#{x.employee.name} #{x.pay_type_id}]"
        else
          err_msg = err_msg << "[#{x.employee.name} #{x.pay_type_id}] 刪除失敗 " << x.errors[:base].join << '\n'
        end
      end

      all_msg = (ok_msg.size==0? '' :(ok_msg << "刪除完成\\n")) << err_msg
      respond_to do |format|
        if err_msg.size>0
          format.html { redirect_to employee_employee_salary_settings_path, alert: all_msg }
        else
          format.html { redirect_to employee_employee_salary_settings_path, notice: all_msg }
        end
      end
    end
  end

  private
    def set_employee
      @employee = current_ou.employees.find(params[:employee_id])
    end

    def set_employee_salary
      @employee_salary = @employee.employee_salary_settings.find(params[:id])
    end

    def employee_salary_params
      params.require(:employee_salary_setting).permit(:employee_id, :pay_type_id, :amt, :memo)
    end

end
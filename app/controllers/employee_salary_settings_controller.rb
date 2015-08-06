class EmployeeSalarySettingsController < ApplicationController
  before_action :set_employee_salary, only: [:show, :edit, :update, :destroy]
  before_action :set_employee_name, only: [:index, :edit, :new]

  def index
    @employee_id = params[:employee_id]
    @employee_salaries = current_ou.employee_salary_settings.includes([:employee, :pay_type]).where(:employee_id => @employee_id)
  end

  def new
    @employee_salary = current_ou.employee_salary_settings.new
  end

  def create
    @employee_salary = current_ou.employee_salary_settings.new(employee_salary_params)
    @employee_salary.employee_id = params[:employee_id]
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

  private
    def set_employee_salary
      @employee_salary = current_ou.employee_salary_settings.find(params[:id])
    end

    def set_employee_name
      @employee_name = current_ou.employees.find_by(id: params[:employee_id]).name
    end

    def employee_salary_params
      params.require(:employee_salary_setting).permit(:employee_id, :pay_type_id, :amt, :memo)
    end

end
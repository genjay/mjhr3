class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  def index
    @employees = current_ou.employees.includes(:department).order(uid: :asc)#page(params[:page])
  end
 
  def show
  end

  def new
    @employee = current_ou.employees.new
  end

  def edit
  end

  def create
    @employee = current_ou.employees.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to employees_path, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to employees_path, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  # def destroy
  #   @employee.destroy
  #   respond_to do |format|
  #     format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  def multi_destroy 
    # render :text => params
    err_msg,ok_msg,all_msg = '','',''
    # ok_msg = 'yyy'
    # render :text => ok_msg
    # return
    params[:ids].each do |f|
      x = Employee.find(f)
      if x.destroy
        ok_msg = ok_msg << "[#{x.uid} #{x.name}]"
      else
        err_msg = err_msg << "[#{x.uid} #{x.name}] 刪除失敗 " << x.errors[:base].join << '\n'
      end
    end

      all_msg = (ok_msg.size==0? '' :(ok_msg << "刪除完成\\n")) << err_msg
      # render :text => all_msg
      respond_to do |format|
        if err_msg.size>0
          format.html { redirect_to employees_path, alert: all_msg }
        else
          format.html { redirect_to employees_path, notice: all_msg }
        end
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = current_ou.employees.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:uid, :name, :department_id, :id_number, :arrive_date, :leave_date, :birthday, :sex, :marriage, :education, :school, :tel1, :tel2, :address1, :address2, :email, :cardno)
    end
end

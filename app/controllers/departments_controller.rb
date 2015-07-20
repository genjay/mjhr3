class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :edit, :update, :destroy]

  # GET /departments
  # GET /departments.json
  def index 
    # session[:xid] = '11123'
    # render :text => session[:xid] 
    # return
    @departments = current_ou.departments.includes(:worktype).order(:uid) 
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
  end

  # GET /departments/new
  def new
    @department = current_ou.departments.new
  end

  # GET /departments/1/edit
  def edit
  end

  # POST /departments
  # POST /departments.json
  def create
    @department = current_ou.departments.new(department_params) 

    respond_to do |format|
      if @department.save
        format.html { redirect_to departments_path, notice: 'Department was successfully created.' }
        format.json { render :show, status: :created, location: @department }
      else
        format.html { render :new }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departments/1
  # PATCH/PUT /departments/1.json
  def update
    # render :text => department_params
    # return
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to departments_path, notice: 'Department was successfully updated.' }
        format.json { render :show, status: :ok, location: @department }
      else
        format.html { render :edit }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    respond_to do |format|
      if @department.destroy
          format.html { redirect_to departments_url, notice: 'Department was successfully destroyed.' }
          format.json { head :no_content }
      else
        # render :text => @department.errors[:base].to_s 
        # return
         format.html { render :edit, notice: 'error',alert: @department.errors[:base] }
      end
    end
  end

  def multi_destroy 
    errors ||=''
    ok_msg ||=''
    all_msg ||=''
    params[:ids].each do |f|
      x = Department.find(f)
      x.destroy
      if x.errors.empty?
        ok_msg = ok_msg + " [#{x.uid} #{x.name}]"  
      else
        errors = errors + "[#{x.uid} #{x.name}] 失敗" + x.errors[:base].join + '\n'
      end
         
      if ok_msg.size>0 
        all_msg = "#{ok_msg} 刪除完成\\n #{errors}" 
      else
        all_msg = "#{errors}" 
      end
    end

    respond_to do |format|
      if errors.size>0 
       format.html { redirect_to departments_path, alert: all_msg } 
      else
       format.html { redirect_to departments_path, notice: all_msg }
      end 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = current_ou.departments.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def department_params
      params.require(:department).permit(:uid, :name, :worktype_id, :upper_id, :is_stoped, :memo, :ou_id)
    end
end

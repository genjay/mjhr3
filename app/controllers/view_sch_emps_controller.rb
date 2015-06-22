class ViewSchEmpsController < ApplicationController
	before_action :set_default

	def set_default
	end

  def index 
   	# @yyyymm = if params[:yyyymm]== '' then 201506 else params[:yyyymm] end
   	yyyymm = params[:yyyymm]
  	emp_id = params[:emp_id] 
 
   	@viewschemps = @current_ou.view_sch_emps.search(yyyymm, emp_id)
  end

  def edit
  	@schemp = ViewSchEmp.find_by(uid:params[:uid], duty_date: params[:duty_date])
  	# render :text => "#{@schemp.uid}#{@schemp.duty_date}"
  end
    # x=SchEmp.new
    # x = @schemp 他會自動對應

  def update
  	# render :text => params
  	# return
  	x = params.require(:view_sch_emp).permit(:duty_date, :employee_id, :worktype_id, :is_holiday)
  	
  	@y = SchEmp.new(x)
  	if @y.save 
  		# format.html { redirect_to view_sch_emps_path, notice: 'Worktype was successfully created.' }
  	else
    end   

  end

  def new (*a)
  	render :text => a
  	return
  	x_params = params.permit(:emp_id)
  	# render :text => x_params
  	# return
  	@schemp = @current_ou.view_sch_emp.find(duty_date:20150601) 

      @department = @current_ou.departments.find(params[:id])
  	# render :text => @schemp.duty_date
  end
end

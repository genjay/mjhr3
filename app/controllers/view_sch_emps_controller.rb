class ViewSchEmpsController < ApplicationController
	before_action :set_default

	def set_default
	end

  def index 
    yyyymm = params[:yyyymm]
  	emp_id = params[:emp_id] 
 
   	@viewschemps = @current_ou.view_sch_emps.search(yyyymm, emp_id)

    @@viewschemps = @viewschemps 
  end

  def edit 
  	@schemp = @@viewschemps.find_by(uid:params[:uid], duty_date: params[:duty_date])
  	# render :text => "#{@schemp.uid}#{@schemp.duty_date}"
  end 

  def update 
  	x = params.require(:view_sch_emp).permit(:duty_date, :employee_id, :worktype_id, :is_holiday)
  	
  	@y = SchEmp.new(x)
  	if @y.save 
  		# format.html { redirect_to view_sch_emps_path, notice: 'Worktype was successfully created.' }
  	else
    end   

  end 
end

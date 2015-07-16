class ViewSchEmpsController < ApplicationController
  before_action :set_viewschemp, only: [:show, :edit, :destroy]

  def index 
    yyyymm = params[:yyyymm]
  	emp_id = params[:emp_id] 
 
   	@viewschemps = @current_ou.view_sch_emps.search(yyyymm, emp_id)

  end

  def edit  
  end 

  def update 
    @viewschemp = @current_ou.view_sch_emps.new(viewschemp_params)

    if @viewschemp.id == 0 
      x = @current_ou.sch_emps.new(viewschemp_params)
    else
      x = @current_ou.sch_emps.find(@viewschemp.id)
      x.assign_attributes(viewschemp_params)
    end

    respond_to do |format|
      if x.save
        format.html { redirect_to view_sch_emps_path, notice: 'Success'}
      else
        format.html { render :edit}
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_viewschemp 
      @viewschemp = @current_ou.view_sch_emps.find_by(uid: params[:uid],duty_date: params[:duty_date]) 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def viewschemp_params
      params.require(:view_sch_emp).permit(:id, :employee_id, :duty_date, :worktype_id, :is_holiday )
    end

end

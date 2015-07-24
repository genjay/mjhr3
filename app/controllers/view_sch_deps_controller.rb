class ViewSchDepsController < ApplicationController
  before_action :set_viewschdep, only: [:show, :edit, :destroy]

  def index 
    yyyymm = params[:yyyymm]
  	dep_id = params[:dep_id] 
 
   	@viewschdeps = current_ou.view_sch_deps.search(yyyymm, dep_id)

  end

  def edit  
  end 

  def update 
    @viewschdep = current_ou.view_sch_deps.new(viewschdep_params)

    if @viewschdep.id == 0 
      x = current_ou.sch_deps.new(viewschdep_params)
    else
      x = current_ou.sch_deps.find(@viewschdep.id)
      x.assign_attributes(viewschdep_params)
    end

    respond_to do |format|
      if x.save
        format.html { redirect_to view_sch_deps_path, notice: 'Success'}
      else
        format.html { render :edit}
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_viewschdep 
      @viewschdep = current_ou.view_sch_deps.find_by(uid: params[:uid],duty_date: params[:duty_date]) 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def viewschdep_params
      params.require(:view_sch_dep).permit(:id, :department_id, :duty_date, :worktype_id, :is_holiday )
    end

end

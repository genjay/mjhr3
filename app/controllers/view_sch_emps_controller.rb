class ViewSchEmpsController < ApplicationController
  def index
  	yyyymm ||= params[:yyyymm]
  	emp_id ||= params[:emp_id]
  	# render :text => yyyymm
  	# return
  	@viewschemps = ViewSchEmp.where(uid: :emp_id).page(params[:pages])
  end
end

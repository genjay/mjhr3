class WorkrestsController < ApplicationController
  before_action :find_worktype

  def index
    # render :text => @worktype.workrests
    @workrests = @worktype.workrests
  end

  def show
    @workrest = @worktype.workrests.find(params[:id])
    # render :text => @workrest
  end

  def edit
    @workrest = @worktype.workrests.find(params[:id])
  end
  

  private

  def find_worktype
    @worktype = Worktype.find(params[:worktype_id])
  end
end

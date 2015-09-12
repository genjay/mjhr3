class CardtimesController < ApplicationController
  def index
  	@cardtimes = Cardtime.where(ou_id:current_ou.id).limit 25
  end

  def import
  	st = Time.now
    # x = params[:file]
    # render :text => x.path
    # return
    # Cardtime.delete_all
    cnt = Cardtime.import(params[:file],current_ou.id) 
    run_time = Time.now - st
    redirect_to cardtimes_path, notice: "#{run_time} 秒，#{cnt} Products imported."
  end

end

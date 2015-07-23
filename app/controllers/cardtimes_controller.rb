class CardtimesController < ApplicationController
  def index
  	@cardtimes = Cardtime.limit 25
  end

  def import
  	st = Time.now
    # x = params[:file]
    # render :text => x.path
    # return
    Cardtime.delete_all
    y = Cardtime.import(params[:file]) 
    run_time = Time.now - st
    redirect_to cardtimes_path, notice: "#{run_time} 秒，#{Cardtime.count}Products imported."
  end

end

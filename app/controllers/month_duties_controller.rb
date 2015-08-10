class MonthDutiesController < ApplicationController
  def index
  end


  def get_calculate
  	# 1.day.ago 回傳的是 utc日期，所以沒用他
  	@default_date = (Time.now - 1.days).strftime('%Y%m%d')
    @yyyymm = 201507
    @duty_fr = 20150701
    @duty_to = 20150731
  	# render 'get_calculate'
  end

  def post_calculate
  	MonthDuty.d04(current_ou.id,params[:yyyymm],params[:duty_fr],params[:duty_to]) 
  	render :text => "#{MonthDuty.count} 筆完成匯入"
  	return
  end

end

class DailyDutiesController < ApplicationController
  def index
  end

  def get_calculate
  	# 1.day.ago 回傳的是 utc日期，所以沒用他
  	@default_date = (Time.now - 1.days).strftime('%Y%m%d')
  	# render 'get_calculate'
  end

  def post_calculate
  	DailyDuty.d04(current_ou,params[:duty_date]) 
  	render :text => "#{DailyDuty.count} 筆完成匯入"
  	return
  end


end

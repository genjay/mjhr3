class DailyDutiesController < ApplicationController
  def index
  end

  def get_calculate
  	# 1.day.ago 回傳的是 utc日期，所以沒用他
  	@default_date = (Time.now - 1.days).strftime('%Y%m%d')
    @default_date = '20150702' # 開發時用
  	# render 'get_calculate'
  end

  def post_calculate
    
    sid = "_#{session.id}_#{session.__id__}"
  	DailyDuty.d04(current_ou.id,params[:duty_date],sid) 
  	render :text => "#{DailyDuty.count} 筆完成匯入"
    # render :text => session.methods
  	return
  end


end

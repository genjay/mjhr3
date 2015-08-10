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
    if Rails.env=='production'
      sid = "_#{session.id}_#{session.__id__}"
    else
      # sid = "_#{session.id}_#{session.__id__}"
      sid = ''
    end
    st = Time.now
  	cnt = DailyDuty.d04(current_ou.id,params[:duty_date],sid) 
    run_time = Time.now - st
  	render :text => "#{cnt} 筆完成匯入 #{run_time} 秒"
    # render :text => session.methods
  	return
  end


end

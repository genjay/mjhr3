class CalendarsController < ApplicationController
  before_action :set_calendar, only: [:show, :edit, :update, :destroy]

  def index 
    yyyymm = params[:yyyymm] || Time.now.strftime('%Y%m')
    if yyyymm.to_s.match(Regexp_yyyymm)
      Calendar.create_by_yyyymm(current_ou.id,yyyymm)
      @calendars = Calendar.search(current_ou.id,yyyymm)
    else
      @calendars = []
      render :index 
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @calendar.update(calendar_params)
        format.html { redirect_to calendars_path, notice: 'Calendar was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private
    def set_calendar
      @calendar = current_ou.calendars.find_by(id: params[:id]) 
    end

    def calendar_params
      params.require(:calendar).permit(:duty_date, :is_holiday)
    end
end
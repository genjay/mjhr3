class CalendarsController < ApplicationController
  before_action :set_calendar, only: [:show, :edit, :update, :destroy]

  def index 
    yyyymm = params[:yyyymm]
    @calendars = current_ou.calendars.search(yyyymm)

    if @calendars.size == 0 && yyyymm != nil
      year = yyyymm[0..3]
      month = yyyymm[4..5]
      check_date = Date.parse("#{year}/#{month}") rescue nil
      if check_date
        days = Time.days_in_month(month.to_i, year.to_i)
        days.times do |day|
          full_date = "#{year}/#{month}/#{day+1}"
          week = Date.parse(full_date).strftime("%A")
          if week == "Sunday" || week == "Saturday"
            is_holiday = 1
          else
            is_holiday = 0
          end
          Calendar.create(ou_id: current_ou.id, duty_date: full_date, is_holiday: is_holiday)
        end
      else
        redirect_to calendars_path, notice: '日期格式不正確'
      end
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
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar
      @calendar = current_ou.calendars.find_by(id: params[:id]) 
    end

    def calendar_params
      params.require(:calendar).permit(:duty_date, :is_holiday)
    end
end
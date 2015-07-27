class CalendarsController < ApplicationController
  before_action :set_calendar, only: [:show, :edit, :destroy]

  def index 
    yyyymm = params[:yyyymm]
    @calendars = current_ou.calendars.search(yyyymm)
  end

  def edit
  end

  def update 
    @calendar = current_ou.calendars.new(calendar_params)

    if @viewschemp.id == 0 
      x = current_ou.calendars.new(calendar_params)
    else
      x = current_ou.calendars.find(@viewschemp.id)
      x.assign_attributes(calendar_params)
    end

    respond_to do |format|
      if x.save
        format.html { redirect_to calendars_path, notice: 'Success'}
      else
        format.html { render :edit}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar
      @calendar = current_ou.calendars.find_by(duty_date: params[:duty_date]) 
    end

    def calendar_params
      params.require(:calendar).permit(:duty_date, :is_holiday, :ou_id)
    end
end
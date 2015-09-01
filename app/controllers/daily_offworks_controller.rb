class DailyOffworksController < ApplicationController
  before_action :set_dailyoffwork, only: [:show, :edit, :update, :destroy]

  def index
    doc_offwork = DocOffwork.find params[:doc_offwork_id]
    @doc_details = doc_offwork.details
  end

  def edit 
  end

  def update
    # render :text => params
    respond_to do |format|
      if @daily_offwork.update(dailyoffwork_params)
        format.html { redirect_to doc_offwork_daily_offworks_path, notice: 'dailyoffwork was successfully updated.' }
      else
        format.html { render :edit }
      end
    end

  end

private 
  def set_dailyoffwork
    @daily_offwork = DailyOffwork.find params[:id]
  end

  def dailyoffwork_params
    params.require(:daily_offwork).permit(:mins_of_duty)
  end
end
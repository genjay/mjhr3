class InsuranceSettingsController < ApplicationController
  before_action :set_insurance_setting, only: [:show, :edit, :update, :destroy]

  # GET /insurance_settings
  # GET /insurance_settings.json
  def index
    @insurance_settings = InsuranceSetting.all
  end

  # GET /insurance_settings/1
  # GET /insurance_settings/1.json
  def show
  end

  # GET /insurance_settings/new
  def new
    @insurance_setting = InsuranceSetting.new
  end

  # GET /insurance_settings/1/edit
  def edit
  end

  # POST /insurance_settings
  # POST /insurance_settings.json
  def create
    @insurance_setting = InsuranceSetting.new(insurance_setting_params)

    respond_to do |format|
      if @insurance_setting.save
        format.html { redirect_to @insurance_setting, notice: 'Insurance setting was successfully created.' }
        format.json { render :show, status: :created, location: @insurance_setting }
      else
        format.html { render :new }
        format.json { render json: @insurance_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /insurance_settings/1
  # PATCH/PUT /insurance_settings/1.json
  def update
    respond_to do |format|
      if @insurance_setting.update(insurance_setting_params)
        format.html { redirect_to @insurance_setting, notice: 'Insurance setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @insurance_setting }
      else
        format.html { render :edit }
        format.json { render json: @insurance_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /insurance_settings/1
  # DELETE /insurance_settings/1.json
  def destroy
    @insurance_setting.destroy
    respond_to do |format|
      format.html { redirect_to insurance_settings_url, notice: 'Insurance setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_insurance_setting
      @insurance_setting = InsuranceSetting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def insurance_setting_params
      params.require(:insurance_setting).permit(:uid, :name, :is_stoped, :memo, :ou_id, :a_rate, :a_employee, :a_compayny, :b_rate, :b_employee, :b_compayny, :c_rate, :c_employee, :c_compayny, :d_rate, :d_employee, :d_compayny, :e_rate, :e_employee, :e_compayny)
    end
end

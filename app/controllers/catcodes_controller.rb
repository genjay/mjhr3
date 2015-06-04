class CatcodesController < ApplicationController
  before_action :set_catcode, only: [:show, :edit, :update, :destroy]

  # GET /catcodes
  # GET /catcodes.json
  def index
    @catcodes = Catcode.all
  end

  # GET /catcodes/1
  # GET /catcodes/1.json
  def show
  end

  # GET /catcodes/new
  def new
    @catcode = Catcode.new
  end

  # GET /catcodes/1/edit
  def edit
  end

  # POST /catcodes
  # POST /catcodes.json
  def create
    @catcode = Catcode.new(catcode_params)

    respond_to do |format|
      if @catcode.save
        format.html { redirect_to @catcode, notice: 'Catcode was successfully created.' }
        format.json { render :show, status: :created, location: @catcode }
      else
        format.html { render :new }
        format.json { render json: @catcode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /catcodes/1
  # PATCH/PUT /catcodes/1.json
  def update
    respond_to do |format|
      if @catcode.update(catcode_params)
        format.html { redirect_to @catcode, notice: 'Catcode was successfully updated.' }
        format.json { render :show, status: :ok, location: @catcode }
      else
        format.html { render :edit }
        format.json { render json: @catcode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /catcodes/1
  # DELETE /catcodes/1.json
  def destroy
    @catcode.destroy
    respond_to do |format|
      format.html { redirect_to catcodes_url, notice: 'Catcode was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_catcode
      @catcode = Catcode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def catcode_params
      params.require(:catcode).permit(:m_name, :col_name, :uid, :name, :is_stoped, :ou_id, :memo)
    end
end

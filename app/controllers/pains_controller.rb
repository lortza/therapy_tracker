class PainsController < ApplicationController
  before_action :set_pain, only: [:show, :edit, :update, :destroy]

  # GET /pains
  # GET /pains.json
  def index
    @pains = Pain.all
  end

  # GET /pains/1
  # GET /pains/1.json
  def show
  end

  # GET /pains/new
  def new
    @pain = Pain.new
  end

  # GET /pains/1/edit
  def edit
  end

  # POST /pains
  # POST /pains.json
  def create
    @pain = Pain.new(pain_params)

    respond_to do |format|
      if @pain.save
        format.html { redirect_to @pain, notice: 'Pain was successfully created.' }
        format.json { render :show, status: :created, location: @pain }
      else
        format.html { render :new }
        format.json { render json: @pain.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pains/1
  # PATCH/PUT /pains/1.json
  def update
    respond_to do |format|
      if @pain.update(pain_params)
        format.html { redirect_to @pain, notice: 'Pain was successfully updated.' }
        format.json { render :show, status: :ok, location: @pain }
      else
        format.html { render :edit }
        format.json { render json: @pain.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pains/1
  # DELETE /pains/1.json
  def destroy
    @pain.destroy
    respond_to do |format|
      format.html { redirect_to pains_url, notice: 'Pain was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pain
      @pain = Pain.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pain_params
      params.require(:pain).permit(:name)
    end
end

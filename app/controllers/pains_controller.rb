class PainsController < ApplicationController
  before_action :set_pain, only: [:show, :edit, :update, :destroy]

  def index
    @pains = current_user.pains.all
  end

  def show
  end

  def new
    @pain = current_user.pains.new
  end

  def edit
  end

  def create
    @pain = current_user.pains.new(pain_params)

    respond_to do |format|
      if @pain.save
        format.html { redirect_to @pain }
        format.json { render :show, status: :created, location: @pain }
      else
        format.html { render :new }
        format.json { render json: @pain.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @pain.update(pain_params)
        format.html { redirect_to @pain }
        format.json { render :show, status: :ok, location: @pain }
      else
        format.html { render :edit }
        format.json { render json: @pain.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pain.destroy
    respond_to do |format|
      format.html { redirect_to pains_url, notice: 'Pain was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_pain
      @pain = Pain.find(params[:id])
    end

    def pain_params
      params.require(:pain).permit(:name)
    end
end

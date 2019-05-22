# frozen_string_literal: true

class PainsController < ApplicationController
  before_action :set_pain, only: %i[edit update destroy]
  before_action :authorize_pain, only: %i[edit update destroy]

  def index
    @pains = current_user.pains.order(:name)
  end

  def new
    @pain = current_user.pains.new
  end

  def edit
  end

  def create
    @pain = current_user.pains.new(pain_params)

    if @pain.save
      redirect_to pains_url
    else
      render :new
    end
  end

  def update
    if @pain.update(pain_params)
      redirect_to pains_url
    else
      render :edit
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

  def authorize_pain
    redirect_to root_path, alert: authorization_alert unless authorized_user?(@pain)
  end

  def pain_params
    params.require(:pain).permit(:name)
  end
end

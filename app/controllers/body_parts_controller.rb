# frozen_string_literal: true

class BodyPartsController < ApplicationController
  before_action :set_body_part, only: %i[edit update destroy]
  before_action :authorize_body_part, only: %i[edit update destroy]

  def index
    @body_parts = current_user.body_parts.all.order(:name)
  end

  def new
    @body_part = current_user.body_parts.new
  end

  def edit
  end

  def create
    @body_part = current_user.body_parts.new(body_part_params)

    if @body_part.save
      redirect_to body_parts_url
    else
      render :new
    end
  end

  def update
    if @body_part.update(body_part_params)
      redirect_to body_parts_url
    else
      render :edit
    end
  end

  def destroy
    @body_part.destroy
    respond_to do |format|
      format.html { redirect_to body_parts_url, notice: "#{@body_part.name} was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private

  def set_body_part
    @body_part = BodyPart.find(params[:id])
  end

  def body_part_params
    params.require(:body_part).permit(:name)
  end

  def authorize_body_part
    redirect_to root_path, alert: authorization_alert if @body_part.user_id != current_user.id
  end
end

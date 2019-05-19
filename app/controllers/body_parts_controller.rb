# frozen_string_literal: true

class BodyPartsController < ApplicationController
  before_action :set_body_part, only: %i[show edit update destroy]
  before_action :authorize_body_part, only: %i[show edit update destroy]

  def index
    @body_parts = current_user.body_parts.all.order(:name)
  end

  def show
  end

  def new
    @body_part = current_user.body_parts.new
  end

  def edit
  end

  def create
    @body_part = current_user.body_parts.new(body_part_params)

    respond_to do |format|
      if @body_part.save
        format.html { redirect_to body_parts_url }
        format.json { render :show, status: :created, location: @body_part }
      else
        format.html { render :new }
        format.json { render json: @body_part.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @body_part.update(body_part_params)
        format.html { redirect_to body_parts_url }
        format.json { render :show, status: :ok, location: @body_part }
      else
        format.html { render :edit }
        format.json { render json: @body_part.errors, status: :unprocessable_entity }
      end
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
    redirect_to root_path, alert: "Whoops! You're not authorized to view that page." if @body_part.user_id != current_user.id
  end
end

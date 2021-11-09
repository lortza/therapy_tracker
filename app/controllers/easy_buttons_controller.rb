# frozen_string_literal: true

class EasyButtonsController < ApplicationController
  before_action :set_easy_button, only: %i[ edit update destroy ]
  before_action :authorize_easy_button, only: %i[ edit update destroy]

  def index
    @easy_buttons = current_user.easy_buttons.order(name: :asc).all
  end

  def new
    @easy_button = current_user.easy_buttons.new
  end

  def edit
  end

  def create
    @easy_button = current_user.easy_buttons.new(easy_button_params)

    if @easy_button.save
      redirect_to easy_buttons_url, notice: "Easy button was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @easy_button.update(easy_button_params)
      redirect_to easy_buttons_url, notice: "Easy button was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @easy_button.destroy
    redirect_to easy_buttons_url, notice: "Easy button was successfully destroyed."
  end

  private

  def authorize_easy_button
    redirect_to root_path, alert: authorization_alert unless authorized_user?(@easy_button)
  end

  def set_easy_button
    @easy_button = current_user.easy_buttons.find(params[:id])
  end

  def easy_button_params
    params.require(:easy_button).permit(:user_id,
                                        :body_part_id,
                                        :pain_id,
                                        :pain_level,
                                        :name)
  end
end

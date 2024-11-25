# frozen_string_literal: true

class PainLogQuickFormValuesController < ApplicationController
  before_action :set_pain_log_quick_form_value, only: %i[edit update destroy]
  before_action :authorize_pain_log_quick_form_value, only: %i[edit update destroy]

  def index
    @pain_log_quick_form_values = current_user.pain_log_quick_form_values
      .search(params[:search])
      .by_name
  end

  def new
    @pain_log_quick_form_value = current_user.pain_log_quick_form_values.new
  end

  def edit
  end

  def create
    @pain_log_quick_form_value = current_user.pain_log_quick_form_values.new(pain_log_quick_form_value_params)

    if @pain_log_quick_form_value.save
      redirect_to pain_log_quick_form_values_url, notice: "#{@pain_log_quick_form_value.name} was created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @pain_log_quick_form_value.update(pain_log_quick_form_value_params)
      redirect_to pain_log_quick_form_values_url, notice: "#{@pain_log_quick_form_value.name} was updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pain_log_quick_form_value.destroy
    redirect_to pain_log_quick_form_values_url, notice: "#{@pain_log_quick_form_value.name} was deleted."
  end

  private

  def authorize_pain_log_quick_form_value
    redirect_to root_path, alert: authorization_alert unless authorized_user?(@pain_log_quick_form_value)
  end

  def set_pain_log_quick_form_value
    @pain_log_quick_form_value = current_user.pain_log_quick_form_values.find(params[:id])
  end

  def pain_log_quick_form_value_params
    params.require(:pain_log_quick_form_value)
      .permit(:user_id, :body_part_id, :pain_id, :pain_level, :trigger, :pain_description, :name)
  end
end

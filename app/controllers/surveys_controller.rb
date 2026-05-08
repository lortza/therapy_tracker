# frozen_string_literal: true

class SurveysController < ApplicationController
  def index
    authorize! Survey, to: :index?

    @surveys = Survey.published.where(user_id: current_user.id)
      .or(Survey.published.available_to_public)
  end

  private

  def set_survey
    @survey = Survey.find(params[:id])
  end
end

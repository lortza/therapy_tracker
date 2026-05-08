# frozen_string_literal: true

class Survey::ResponsesController < ApplicationController
  before_action :set_survey, only: [:index, :new, :create]
  # before_action :set_survey_response, only: [:show]

  def index
    @survey_responses = current_user.survey_responses.where(survey: @survey).order(occurred_at: :desc)
  end

  def new
    @survey_response = @survey.responses.new
    @survey.questions.ordered.each do |question|
      @survey_response.answers.build(question: question)
    end
  end

  def create
    @survey_response = @survey.responses.new(survey_response_params)
    @survey_response.user = current_user
    @survey_response.occurred_at = Time.current

    if @survey_response.save
      redirect_to survey_responses_path(@survey), notice: "Response submitted successfully."
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_survey_response
    @survey_response = current_user.survey_responses.find(params[:id])
  end

  def survey_response_params
    params.require(:survey_response).permit(
      :notes,
      :occurred_at,
      :survey_id,
      answers_attributes: [
        :id,
        :survey_question_id,
        :survey_response_id,
        :survey_answer_option_id
      ]
    )
  end
end

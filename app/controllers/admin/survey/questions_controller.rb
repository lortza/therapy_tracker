# frozen_string_literal: true

class Admin::Survey::QuestionsController < AdminController
  before_action :set_question, only: [:edit, :update, :destroy]
  before_action :set_category, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_survey, only: [:new, :create, :edit, :update, :destroy]

  def new
    @question = @category.questions.new(position: nil)
    authorize! @question

    respond_to do |format|
      format.turbo_stream
    end
  end

  def create
    @question = @category.questions.new(question_params)
    authorize! @question

    respond_to do |format|
      if @question.save
        @survey.calculate_score_range_steps_points!

        format.turbo_stream
        format.html { redirect_to admin_survey_path(@survey), notice: "Question was successfully created." }
      else
        format.turbo_stream { render :new }
        format.html { render :new, status: :unprocessable_content }
      end
    end
  end

  def edit
    authorize! @question

    respond_to do |format|
      format.turbo_stream
    end
  end

  def update
    authorize! @question

    respond_to do |format|
      if @question.update(question_params)
        @survey.calculate_score_range_steps_points!
        format.turbo_stream
        format.html { redirect_to admin_survey_path(@survey), notice: "Question was successfully updated." }
      else
        format.turbo_stream { render :edit }
        format.html { render :edit, status: :unprocessable_content }
      end
    end
  end

  def destroy
    authorize! @question

    respond_to do |format|
      if @question.destroy
        @survey.calculate_score_range_steps_points!

        format.turbo_stream
        format.html { redirect_to admin_survey_path(@survey), notice: "Question was successfully destroyed." }
      end
    end
  end

  private

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_category
    @category = Survey::Category.find(params[:category_id])
  end

  def set_question
    @question = Survey::Question.find(params[:id])
  end

  def question_params
    params.require(:survey_question).permit(:text, :position)
  end
end

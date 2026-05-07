class Admin::Survey::AnswerOptionsController < AdminController
  before_action :set_answer_option, only: [:edit, :update, :destroy]
  before_action :set_survey, only: [:new, :create, :edit, :update, :destroy]

  def new
    @answer_option = @survey.answer_options.new(value: calculated_answer_option_value)
    authorize! @answer_option

    respond_to do |format|
      format.turbo_stream
    end
  end

  def create
    @answer_option = Survey::AnswerOption.new(answer_option_params)
    authorize! @answer_option

    respond_to do |format|
      if @answer_option.save
        @survey.calculate_score_range_steps_points!
        format.turbo_stream
        format.html { redirect_to admin_survey_path(@survey), notice: "Answer option was successfully created." }
      else
        format.turbo_stream { render :new }
        format.html { render :new, status: :unprocessable_content }
      end
    end
  end

  def edit
    authorize! @answer_option

    respond_to do |format|
      format.turbo_stream
    end
  end

  def update
    authorize! @answer_option

    respond_to do |format|
      if @answer_option.update(answer_option_params)
        @survey.calculate_score_range_steps_points!
        format.turbo_stream
        format.html { redirect_to admin_survey_path(@survey), notice: "Answer option was successfully updated." }
      else
        format.turbo_stream { render :edit }
        format.html { render :edit, status: :unprocessable_content }
      end
    end
  end

  def destroy
    authorize! @answer_option

    respond_to do |format|
      if @answer_option.destroy
        @survey.calculate_score_range_steps_points!
        format.turbo_stream
        format.html { redirect_to admin_survey_path(@survey), notice: "#{@answer_option.name} was successfully destroyed." }
      end
    end
  end

  private

  def calculated_answer_option_value
    @survey.answer_options.any? ? (@survey.answer_options.maximum(:value).to_i + 1) : 0
  end

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_answer_option
    @answer_option = Survey::AnswerOption.find(params[:id])
  end

  def answer_option_params
    params.require(:survey_answer_option).permit(:name, :value, :survey_id)
  end
end

class Admin::Survey::ScoreRangeStepsController < AdminController
  before_action :set_score_range_step, only: [:edit, :update, :destroy]
  before_action :set_survey, only: [:new, :create, :edit, :update, :destroy]

  def new
    @score_range_step = @survey.score_range_steps.new(position: calculated_score_range_step_position)
    authorize! @score_range_step

    respond_to do |format|
      format.turbo_stream
    end
  end

  def create
    @score_range_step = Survey::ScoreRangeStep.new(score_range_step_params)
    authorize! @score_range_step

    respond_to do |format|
      if @score_range_step.save
        @survey.calculate_score_range_steps_points!
        format.turbo_stream
        format.html { redirect_to admin_survey_path(@survey), notice: "Score range step was successfully created." }
      else
        format.turbo_stream { render :new }
        format.html { render :new, status: :unprocessable_content }
      end
    end
  end

  def edit
    authorize! @score_range_step

    respond_to do |format|
      format.turbo_stream
    end
  end

  def update
    authorize! @score_range_step

    respond_to do |format|
      if @score_range_step.update(score_range_step_params)
        @survey.calculate_score_range_steps_points!
        format.turbo_stream
        format.html { redirect_to admin_survey_path(@survey), notice: "Score range step was successfully updated." }
      else
        format.turbo_stream { render :edit }
        format.html { render :edit, status: :unprocessable_content }
      end
    end
  end

  def destroy
    authorize! @score_range_step

    respond_to do |format|
      if @score_range_step.destroy
        @survey.calculate_score_range_steps_points!
        format.turbo_stream
        format.html { redirect_to admin_survey_path(@survey), notice: "#{@score_range_step.name} was successfully destroyed." }
      end
    end
  end

  private

  def calculated_score_range_step_position
    @survey.score_range_steps.maximum(:position).to_i + 1
  end

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_score_range_step
    @score_range_step = Survey::ScoreRangeStep.find(params[:id])
  end

  def score_range_step_params
    params.require(:survey_score_range_step).permit(:name, :position, :description, :survey_id)
  end
end

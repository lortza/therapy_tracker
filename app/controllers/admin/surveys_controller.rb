class Admin::SurveysController < AdminController
  before_action :set_survey, only: [:show, :edit, :update, :publish, :archive, :make_public, :make_private, :destroy]

  def index
    @surveys = current_user.surveys.all
    @public_surveys = Survey.where(available_to_public: true).where.not(user_id: current_user.id)
  end

  def new
    @survey = current_user.surveys.new
  end

  def create
    @survey = current_user.surveys.new(survey_params)
    authorize! @survey

    if @survey.save
      redirect_to admin_survey_path(@survey)
    else
      render :new
    end
  end

  def show
    authorize! @survey
  end

  def edit
    authorize! @survey
  end

  def update
    authorize! @survey

    if @survey.update(survey_params)
      redirect_to admin_survey_path(@survey)
    else
      render :edit
    end
  end

  def destroy
    authorize! @survey

    @survey.destroy
    redirect_to admin_surveys_path, notice: "Survey deleted successfully."
  end

  def publish
    authorize! @survey

    @survey.published!
    redirect_to admin_survey_path(@survey), notice: "Survey published successfully."
  end

  def archive
    authorize! @survey

    @survey.archived!
    redirect_to admin_survey_path(@survey), notice: "Survey archived successfully."
  end

  def make_public
    authorize! @survey

    @survey.update(available_to_public: true)
    redirect_to admin_survey_path(@survey), notice: "Survey is now public."
  end

  def make_private
    authorize! @survey

    @survey.update(available_to_public: false)
    redirect_to admin_survey_path(@survey), notice: "Survey is now private."
  end

  private

  def set_survey
    @survey = Survey.find(params[:id])
  end

  def survey_params
    params.require(:survey).permit(:name, :description, :instructions, :status, :available_to_public)
  end
end

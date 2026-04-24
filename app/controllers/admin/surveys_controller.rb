class Admin::SurveysController < AdminController
  before_action :set_survey, only: [:show, :publish, :archive, :make_public, :make_private, :destroy]

  def index
    @surveys = current_user.surveys.all
    @public_surveys = Survey.where(available_to_public: true).where.not(user_id: current_user.id)
  end

  def show
    authorize! @survey
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
    authorize! @survey, :make_private?

    @survey.update(available_to_public: false)
    redirect_to admin_survey_path(@survey), notice: "Survey is now private."
  end

  def destroy
    authorize! @survey, :destroy?

    @survey.destroy
    redirect_to admin_surveys_path, notice: "Survey deleted successfully."
  end

  private

  def set_survey
    @survey = Survey.find(params[:id])
  end

  def survey_params
    params.require(:survey).permit(:name, :description, :status, :available_to_public)
  end
end

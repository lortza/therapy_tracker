class Admin::SurveysController < AdminController
  before_action :set_survey, only: [:show]

  def index
    @surveys = Survey.all
  end

  def show
  end

  private

  def set_survey
    @survey = Survey.find(params[:id])
  end

  def survey_params
    params.require(:survey).permit(:name, :description, :published, :available_to_public)
  end
end

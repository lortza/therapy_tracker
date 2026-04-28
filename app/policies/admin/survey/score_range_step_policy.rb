class Admin::Survey::ScoreRangeStepPolicy < ApplicationPolicy
  def new?
    allowed_to?(:edit?, record.survey, with: Admin::SurveyPolicy) && record.survey.questions.any?
  end

  def create?
    allowed_to?(:edit?, record.survey, with: Admin::SurveyPolicy) && record.survey.questions.any?
  end

  def edit?
    allowed_to?(:edit?, record.survey, with: Admin::SurveyPolicy) && record.survey.questions.any?
  end

  def update?
    allowed_to?(:edit?, record.survey, with: Admin::SurveyPolicy) && record.survey.questions.any?
  end

  def destroy?
    allowed_to?(:edit?, record.survey, with: Admin::SurveyPolicy)
  end
end

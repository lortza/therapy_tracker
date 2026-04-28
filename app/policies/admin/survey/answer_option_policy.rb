class Admin::Survey::AnswerOptionPolicy < ApplicationPolicy
  def new?
    allowed_to?(:edit?, record.survey, with: Admin::SurveyPolicy)
  end

  def create?
    allowed_to?(:edit?, record.survey, with: Admin::SurveyPolicy)
  end

  def edit?
    allowed_to?(:edit?, record.survey, with: Admin::SurveyPolicy)
  end

  def update?
    allowed_to?(:edit?, record.survey, with: Admin::SurveyPolicy)
  end

  def destroy?
    allowed_to?(:edit?, record.survey, with: Admin::SurveyPolicy)
  end
end

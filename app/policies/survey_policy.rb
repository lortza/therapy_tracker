class SurveyPolicy < ApplicationPolicy
  # See https://actionpolicy.evilmartians.io/#/writing_policies
  #
  # Scoping
  # See https://actionpolicy.evilmartians.io/#/scoping
  #
  # relation_scope do |relation|
  #   next relation if user.admin?
  #   relation.where(user: user)
  # end

  def index?
    admin?
  end

  def show?
    admin?
  end

  private

  # Will be in-use when we allow non-admin users to create public surveys
  def owner_or_public?
    record.available_to_public? || owner?
  end
end

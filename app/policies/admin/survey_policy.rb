class Admin::SurveyPolicy < ApplicationPolicy
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

  def new?
    admin?
  end

  def create?
    admin?
  end

  def show?
    admin? && owner_or_public?
  end

  def edit?
    admin? && owner_or_public? && record.draft?
  end

  def update?
    admin? && owner_or_public? && record.draft?
  end

  def destroy?
    admin? && owner_or_public? && record.draft?
  end

  def publish?
    admin? && owner_or_public? && (record.draft? || record.archived?)
  end

  def archive?
    admin? && owner_or_public? && record.published?
  end

  def make_public?
    admin? && owner_or_public? && record.published? && !record.available_to_public?
  end

  def make_private?
    admin? && owner_or_public? && record.published? && record.available_to_public?
  end

  private

  def owner_or_public?
    record.available_to_public? || owner?
  end
end

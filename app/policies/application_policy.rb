# Base class for application policies
class ApplicationPolicy < ActionPolicy::Base
  # Configure additional authorization contexts here
  # (`user` is added by default).
  #
  #   authorize :account, optional: true
  #
  # Read more about authorization context: https://actionpolicy.evilmartians.io/#/authorization_context

  private

  def owner?
    record.user_id == user.id
  end

  def admin?
    user.admin?
  end

  def owner_or_admin?
    owner? || admin?
  end
end

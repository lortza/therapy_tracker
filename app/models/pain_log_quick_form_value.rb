# frozen_string_literal: true

class PainLogQuickFormValue < ApplicationRecord
  extend Sortable
  extend Searchable

  belongs_to :user
  belongs_to :pain
  belongs_to :body_part

  validates :name,
    presence: true,
    uniqueness: {
      case_sensitive: false,
      scope: :user_id
    }

  validates :pain_level,
    presence: true,
    numericality: true

  def loggable_attributes
    attributes
      .except("id", "name", "created_at", "updated_at")
      .merge(occurred_at: Time.current)
  end
end

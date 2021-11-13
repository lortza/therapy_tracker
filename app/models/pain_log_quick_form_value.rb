# frozen_string_literal: true

class PainLogQuickFormValue < ApplicationRecord

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
end

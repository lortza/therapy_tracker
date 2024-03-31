# frozen_string_literal: true

class SlitLog < ApplicationRecord
  belongs_to :user

  validates :occurred_at, presence: true

  DOSE_TO_PLACE_ORDER = 60
end

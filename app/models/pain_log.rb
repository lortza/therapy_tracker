# frozen_string_literal: true

class PainLog < ApplicationRecord
  belongs_to :user
  belongs_to :body_part
  belongs_to :pain

  validates :datetime_occurred,
            :body_part_id,
            :pain_id,
            :pain_description,
            :trigger,
            presence: true

  validates :pain_level,
            presence: true,
            numericality: true

  delegate :name, to: :pain, prefix: true
  delegate :name, to: :body_part, prefix: true
end

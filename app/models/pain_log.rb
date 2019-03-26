class PainLog < ApplicationRecord
  belongs_to :user

  validates :target_body_part,
            :datetime_occurred,
            :pain_description,
            :trigger,
            presence: true

  validates :pain_level,
            presence: true,
            numericality: true


end

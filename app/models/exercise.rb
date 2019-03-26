class Exercise < ApplicationRecord
  belongs_to :user
  has_many :exercise_logs

  validates :name,
            :description,
            presence: true
end

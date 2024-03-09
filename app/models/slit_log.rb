# frozen_string_literal: true

class SlitLog < ApplicationRecord
  belongs_to :user

  validates :datetime_occurred, presence: true
end

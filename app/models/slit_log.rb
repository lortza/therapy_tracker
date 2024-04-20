# frozen_string_literal: true

class SlitLog < ApplicationRecord
  belongs_to :user

  validates :occurred_at, presence: true
end

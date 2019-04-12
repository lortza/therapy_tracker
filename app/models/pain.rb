# frozen_string_literal: true

class Pain < ApplicationRecord
  belongs_to :user
  has_many :pain_logs

  validates :name, presence: true

  def self.has_logs
    joins(:pain_logs).group('pains.id').order(:id)
  end
end

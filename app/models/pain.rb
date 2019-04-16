# frozen_string_literal: true

class Pain < ApplicationRecord
  belongs_to :user
  has_many :pain_logs
  has_many :logs, foreign_key: 'user_id', class_name: 'PainLog'

  validates :name, presence: true

  def self.has_logs
    joins(:pain_logs).group('pains.id').order(:id)
  end

  def self.log_count_by_name
    has_logs.map do |pain|
      [pain.name, pain.pain_logs.count]
    end
  end
end

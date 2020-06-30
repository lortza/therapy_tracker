# frozen_string_literal: true

class PainLog < ApplicationRecord
  extend Log

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

  delegate :name, to: :body_part, prefix: true
  delegate :name, to: :pain, prefix: true

  class << self
    def group_by_pain_and_count
      pain_ids_and_counts = group(:pain_id).count
      pain_ids_and_counts.map do |k, v|
        [Pain.find(k).name, v]
      end
    end
    # def avg_pain_level_by_day
    #   x = PainLog.all.map do |log|
    #     [log.datetime_occurred.to_date => log.pain_level]
    #   end
    # end
  end

  def self.search(pain_type: '', search_terms: '')
    return all if pain_type.blank? && search_terms.blank?

    if pain_type.present? && search_terms.present?
      pain = Pain.find_by(name: pain_type)
      where('pain_id = ? AND pain_description ILIKE ?', pain.id, "%#{search_terms}%")
    elsif pain_type.present?
      pain = Pain.find_by(name: pain_type)
      where(pain_id: pain.id)
    else
      where('pain_description ILIKE ?', "%#{search_terms}%")
    end
  end
end

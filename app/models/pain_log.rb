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

  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def self.search(body_part_name: '', pain_name: '', search_terms: '')
    return all if body_part_name.blank? && pain_name.blank? && search_terms.blank?

    pain = Pain.find_by(name: pain_name)
    body_part = BodyPart.find_by(name: body_part_name)

    if pain.present? && body_part.present?
      where('pain_id = ? AND body_part_id = ?', pain.id, body_part.id).with_search_terms(search_terms)
    elsif pain.present?
      where('pain_id = ?', pain.id).with_search_terms(search_terms)
    elsif body_part.present?
      where('body_part_id = ?', body_part.id).with_search_terms(search_terms)
    else
      with_search_terms(search_terms)
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def self.with_search_terms(search_terms)
    where("concat_ws(' ', trigger, pain_description) ILIKE ?", "%#{search_terms}%")
  end
end

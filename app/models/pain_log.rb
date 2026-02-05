# frozen_string_literal: true

# == Schema Information
#
# Table name: pain_logs
#
#  id               :bigint           not null, primary key
#  occurred_at      :datetime
#  pain_description :text             default("")
#  pain_level       :integer
#  trigger          :text             default("")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  body_part_id     :bigint
#  pain_id          :bigint
#  user_id          :bigint
#
# Indexes
#
#  index_pain_logs_on_body_part_id  (body_part_id)
#  index_pain_logs_on_occurred_at   (occurred_at)
#  index_pain_logs_on_pain_id       (pain_id)
#  index_pain_logs_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (body_part_id => body_parts.id)
#  fk_rails_...  (pain_id => pains.id)
#  fk_rails_...  (user_id => users.id)
#
class PainLog < ApplicationRecord
  extend Log

  belongs_to :user
  belongs_to :body_part
  belongs_to :pain

  validates :occurred_at,
    :body_part_id,
    :pain_id,
    presence: true

  validates :pain_level,
    presence: true,
    numericality: true

  delegate :name, to: :body_part, prefix: true
  delegate :name, to: :pain, prefix: true

  class << self
    # rubocop:disable Metrics/PerceivedComplexity
    def search(body_part_id: "", pain_id: "", search_terms: "")
      return all if body_part_id.blank? && pain_id.blank? && search_terms.blank?

      if pain_id.present? && body_part_id.present?
        where("pain_id = ? AND body_part_id = ?", pain_id, body_part_id).with_search_terms(search_terms)
      elsif pain_id.present?
        where(pain_id: pain_id).with_search_terms(search_terms)
      elsif body_part_id.present?
        where(body_part_id: body_part_id).with_search_terms(search_terms)
      else
        with_search_terms(search_terms)
      end
    end
    # rubocop:enable Metrics/PerceivedComplexity

    def with_search_terms(search_terms)
      where("concat_ws(' ', trigger, pain_description) ILIKE ?", "%#{search_terms}%")
    end
  end
end

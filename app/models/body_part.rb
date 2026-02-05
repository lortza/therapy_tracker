# == Schema Information
#
# Table name: body_parts
#
#  id         :bigint           not null, primary key
#  archived   :boolean          default(FALSE)
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_body_parts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

# frozen_string_literal: true

class BodyPart < ApplicationRecord
  extend Sortable
  extend Searchable

  belongs_to :user
  has_many :pain_log_quick_form_values, dependent: :destroy
  has_many :exercise_logs, dependent: :destroy
  has_many :pain_logs, dependent: :destroy
  has_many :pt_session_logs, dependent: :destroy

  validates :name,
    presence: true,
    uniqueness: {
      case_sensitive: false,
      scope: :user_id
    }

  def self.active
    where(archived: false)
  end
end

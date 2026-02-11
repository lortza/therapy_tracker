# == Schema Information
#
# Table name: pains
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_pains_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

# frozen_string_literal: true

class Pain < ApplicationRecord
  extend Sortable
  extend Searchable

  belongs_to :user
  has_many :pain_log_quick_form_values, dependent: :destroy
  has_many :pain_logs, dependent: :destroy
  has_many :logs, class_name: "PainLog", dependent: :destroy, inverse_of: :pain

  validates :name, presence: true,
    uniqueness: {
      case_sensitive: false,
      scope: :user_id
    }

  class << self
    def logs?
      joins(:pain_logs).group("pains.id").order(:id)
    end
  end
end

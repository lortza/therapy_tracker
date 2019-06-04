# frozen_string_literal: true

class Pain < ApplicationRecord
  extend Nameable

  belongs_to :user
  has_many :pain_logs, dependent: :destroy
  has_many :logs, foreign_key: 'pain_id', class_name: 'PainLog', dependent: :destroy, inverse_of: :pain

  validates :name, presence: true,
                   uniqueness: {
                     case_sensitive: false,
                     scope: :user_id
                   }

  class << self
    def logs?
      joins(:pain_logs).group('pains.id').order(:id)
    end

    def log_count_by_name
      logs?.map do |pain|
        [pain.name, pain.pain_logs.count]
      end
    end
  end
end

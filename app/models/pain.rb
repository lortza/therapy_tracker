class Pain < ApplicationRecord
  belongs_to :user
  has_many :pain_logs

  validates :name, presence: true
end

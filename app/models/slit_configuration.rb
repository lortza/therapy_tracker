# == Schema Information
#
# Table name: slit_configurations
#
#  id                :uuid             not null, primary key
#  drops_dose_qty    :integer          not null
#  hold_time_seconds :integer          not null
#  max_bottle_doses  :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_slit_configurations_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class SlitConfiguration < ApplicationRecord
  belongs_to :user

  validates :max_bottle_doses, presence: true
  validates :hold_time_seconds, presence: true
  validates :drops_dose_qty, presence: true
end

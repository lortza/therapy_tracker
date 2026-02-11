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
require "rails_helper"

RSpec.describe SlitConfiguration, type: :model do
  context "associations" do
    it { should belong_to(:user) }
  end

  context "validations" do
    it { should validate_presence_of(:max_bottle_doses) }
    it { should validate_presence_of(:hold_time_seconds) }
    it { should validate_presence_of(:drops_dose_qty) }
  end
end

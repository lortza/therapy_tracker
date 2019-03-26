require 'rails_helper'

RSpec.describe PainLog, type: :model do
  context "associations" do
    it { should belong_to(:user) }
  end

  context "validations" do
    it { should validate_presence_of(:datetime_occurred) }
    it { should validate_presence_of(:target_body_part) }
    it { should validate_presence_of(:pain_level) }
    it { should validate_presence_of(:pain_description) }
    it { should validate_presence_of(:trigger) }

    it { should validate_numericality_of(:pain_level) }
  end
end

require 'rails_helper'

RSpec.describe Exercise, type: :model do
  context "associations" do
    it { should belong_to(:user) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
  end
end

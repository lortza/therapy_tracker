# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pain, type: :model do
  context "associations" do
    it { should belong_to(:user) }
    it { should have_many(:pain_logs) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
  end
end

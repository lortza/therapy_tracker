# frozen_string_literal: true

require "rails_helper"

RSpec.describe Survey::Enrollment, type: :model do
  context "associations" do
    it { should belong_to(:survey) }
    it { should belong_to(:user) }
  end
end

require 'rails_helper'

RSpec.describe PtSessionExercise, type: :model do
  context "associations" do
    it { should belong_to(:pt_session) }
    it { should belong_to(:exercise) }
  end

  context "validations" do
    it { should validate_presence_of(:pt_session) }
    it { should validate_presence_of(:exercise) }
  end

  context "delegations" do
    it { should delegate_method(:name).to(:exercise).with_prefix }
  end
end

require 'rails_helper'

RSpec.describe Cat, type: :model do
  context "validations" do
    subject { Cat.create(name: 'ABC') }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end

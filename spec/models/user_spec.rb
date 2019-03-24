require 'rails_helper'

RSpec.describe User, type: :model do
  context "associations" do
    it { should have_many(:log_entries) }
  end

  describe '#full_name' do
    it 'displays the users full name' do
      user = build(:user, first_name: 'first', last_name: 'last')
      expect(user.full_name).to eq('first last')
    end
  end
end

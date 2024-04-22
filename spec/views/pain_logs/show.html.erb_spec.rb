# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pain_logs/show', type: :view do
  before(:each) do
    @user = create(:user)
    @pain_log = create(:pain_log, occurred_at: '2019-03-25 20:15:37', user_id: @user.id).decorate
  end

  it 'renders attributes in <div>' do
    allow(view).to receive(:current_user).and_return(@user)
    render
    expect(rendered).to match(/user\d+@example.com/)
    expect(rendered).to match(/03\/25\/19 at 08:15PM/)
    expect(rendered).to match(/body_part\d/)
    expect(rendered).to match(/\d/)
    expect(rendered).to match(/sample pain description/)
    expect(rendered).to match(/sample pain trigger/)
  end
end

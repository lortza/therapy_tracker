# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'exercise_logs/show', type: :view do
  before(:each) do
    @user = create(:user)
    @exercise_log = create(:exercise_log, user_id: @user.id)
  end

  it 'renders attributes in <div>' do
    allow(view).to receive(:current_user).and_return(@user)
    render
    expect(rendered).to match(%r{2 sets / 10 reps at 5 seconds each})
    expect(rendered).to match(%r{Sat 03/23/19 at 02:08PM})
    expect(rendered).to match(/exercise\d/)
    expect(rendered).to match(/description of exercise\d/)
    expect(rendered).to match(/body_part\d/)
    expect(rendered).to match(/Burn at Set 2, Rep 5/)
    expect(rendered).to match(/progress note body/)
  end
end

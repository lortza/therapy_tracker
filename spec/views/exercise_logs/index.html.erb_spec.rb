# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'exercise_logs/index', type: :view do
  before(:each) do
    @user = create(:user)
    create(:exercise_log, user_id: @user.id)
    create(:exercise_log, user_id: @user.id)
    @logs = @user.exercise_logs.at_home
                 .paginate(page: params[:page], per_page: 25)
  end

  it 'renders a list of exercise_logs' do
    allow(view).to receive(:current_user).and_return(@user)
    render
    assert_select 'div.card-body>p', count: 2
    assert_select 'div.card-body>h5', text: 'Exercise: Sat 03/23/19 at 02:08PM', count: 2
    assert_select 'div.card-body>p>strong', text: /Body Part\d+:/, count: 2
    assert_select 'div.card-body>p', text: %r{Exercise\d+: 2 sets / 10 reps at 5 seconds each}, count: 2
    assert_select 'div.card-body>p>small', text: %r{Progress: exercise burn at Set 2 / Rep 5.}, count: 2
    assert_select 'div.card-body>p>small', text: /progress note body/, count: 2
  end
end

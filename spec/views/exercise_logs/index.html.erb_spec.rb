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
    render
    assert_select 'div.card-body>p', count: 2
  end
end

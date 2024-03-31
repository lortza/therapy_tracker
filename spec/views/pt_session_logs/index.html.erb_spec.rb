# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pt_session_logs/index', type: :view do
  before(:each) do
    @user = create(:user)
    create(:pt_session_log, user_id: @user.id)
    create(:pt_session_log, user_id: @user.id)
    logs = @user.pt_session_logs.order(occurred_at: 'DESC').paginate(page: params[:page], per_page: 10)
    @logs = PtSessionLogDecorator.decorate_collection(logs)
  end

  it 'renders a list of pt_session_logs' do
    allow(view).to receive(:current_user).and_return(@user)
    render
    assert_select 'div.card-body>p', count: 2
    assert_select 'div.card-body>h5', text: 'PT Session: Mon 03/25/19 at 10:29PM', count: 2
    assert_select 'div.card-body>p>strong', text: /Body Part\d+:/, count: 2
    assert_select 'div.card-body>p', text: /\d{1,2} minutes/, count: 2
    assert_select 'div.card-body>p>small', text: /sample exercise notes/, count: 2
  end
end

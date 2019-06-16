# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pt_sessions/index', type: :view do
  before(:each) do
    @user = create(:user)
    create(:pt_session, user_id: @user.id)
    create(:pt_session, user_id: @user.id)
    @logs = @user.pt_sessions.order(datetime_occurred: 'DESC').paginate(page: params[:page], per_page: 10)
  end

  it 'renders a list of pt_sessions' do
    allow(view).to receive(:current_user).and_return(@user)
    render
    assert_select 'div.card-body>p', count: 2
    assert_select 'div.card-body>header>h5', text: 'Mon 03/25/19 at 10:29PM', count: 2
    assert_select 'div.card-body>p>strong', text: /Body Part\d+:/, count: 2
    assert_select 'div.card-body>p', text: /\d{1,2} minutes/, count: 2
    assert_select 'div.card-body>p>small', text: /sample exercise notes/, count: 2
  end
end

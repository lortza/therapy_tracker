# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pain_logs/index', type: :view do
  before(:each) do
    @user = create(:user)
    create(:pain_log, user_id: @user.id)
    create(:pain_log, user_id: @user.id)
    @logs = @user.pain_logs.order(datetime_occurred: 'DESC').paginate(page: params[:page], per_page: 25)
  end

  it 'renders a list of pain_logs' do
    allow(view).to receive(:current_user).and_return(@user)
    render
    assert_select 'div.card-body>p', count: 2
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pain_logs/edit', type: :view do
  before(:each) do
    @user = create(:user)
    @pain_log = create(:pain_log, user_id: @user.id).decorate
  end

  it 'renders the edit pain_log form' do
    allow(view).to receive(:current_user).and_return(@user)
    render

    assert_select 'form[action=?][method=?]', pain_log_path(@pain_log), 'post' do
      assert_select 'select[name=?]', 'pain_log[body_part_id]'

      # assert_select 'select[name=?]', /pain_log\[occurred_at\(\d+[i]\)\]/

      assert_select 'select[name=?]', 'pain_log[pain_id]'

      assert_select 'input[name=?]', 'pain_log[pain_level]'

      assert_select 'textarea[name=?]', 'pain_log[trigger]'

      assert_select 'textarea[name=?]', 'pain_log[pain_description]'
    end
  end
end

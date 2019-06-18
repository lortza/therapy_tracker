# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pt_session_logs/edit', type: :view do
  before(:each) do
    @user = create(:user)
    @pt_session_log = create(:pt_session_log, user_id: @user.id)
  end

  it 'renders the edit pt_session_log form' do
    allow(view).to receive(:current_user).and_return(@user)
    render

    assert_select 'form[action=?][method=?]', pt_session_log_path(@pt_session_log), 'post' do
      assert_select 'select[name=?]', 'pt_session_log[body_part_id]'

      # assert_select 'select[name=?]', /pt_session_log\[datetime_occurred\(\d+i\)\]/

      assert_select 'textarea[name=?]', 'pt_session_log[questions]'

      assert_select 'textarea[name=?]', 'pt_session_log[exercise_notes]'

      assert_select 'textarea[name=?]', 'pt_session_log[homework]'

      assert_select 'input[name=?]', 'pt_session_log[homework_exercise_ids][]'
    end
  end
end

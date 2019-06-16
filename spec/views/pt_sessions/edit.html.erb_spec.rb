# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pt_sessions/edit', type: :view do
  before(:each) do
    @user = create(:user)
    @pt_session = create(:pt_session, user_id: @user.id)
  end

  it 'renders the edit pt_session form' do
    allow(view).to receive(:current_user).and_return(@user)
    render

    assert_select 'form[action=?][method=?]', pt_session_path(@pt_session), 'post' do
      assert_select 'select[name=?]', 'pt_session[body_part_id]'

      # assert_select 'select[name=?]', /pt_session\[datetime_occurred\(\d+i\)\]/

      assert_select 'textarea[name=?]', 'pt_session[questions]'

      assert_select 'textarea[name=?]', 'pt_session[exercise_notes]'

      assert_select 'textarea[name=?]', 'pt_session[homework]'

      assert_select 'input[name=?]', 'pt_session[homework_exercise_ids][]'
    end
  end
end

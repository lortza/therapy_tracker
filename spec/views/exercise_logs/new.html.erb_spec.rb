# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'exercise_logs/new', type: :view do
  before(:each) do
    @user = create(:user)
    @exercise_log = build(:exercise_log, user_id: @user.id).decorate
  end

  it 'renders new exercise_log form' do
    allow(view).to receive(:current_user).and_return(@user)
    render

    assert_select 'form[action=?][method=?]', exercise_logs_path, 'post' do
      assert_select 'select[name=?]', 'exercise_log[body_part_id]'

      # assert_select 'select[name=?]', /exercise_log\[occurred_at\(\d+[i]\)\]/

      assert_select 'select[name=?]', 'exercise_log[exercise_id]'

      assert_select 'input[name=?]', 'exercise_log[sets]'

      assert_select 'input[name=?]', 'exercise_log[reps]'

      assert_select 'input[name=?]', 'exercise_log[rep_length]'

      assert_select 'input[name=?]', 'exercise_log[per_side]'

      assert_select 'input[name=?]', 'exercise_log[resistance]'

      assert_select 'input[name=?]', 'exercise_log[burn_set]'

      assert_select 'input[name=?]', 'exercise_log[burn_rep]'

      assert_select 'textarea[name=?]', 'exercise_log[progress_note]'
    end
  end
end

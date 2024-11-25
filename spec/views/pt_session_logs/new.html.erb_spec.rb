# frozen_string_literal: true

require "rails_helper"

RSpec.describe "pt_session_logs/new", type: :view do
  before(:each) do
    @user = create(:user)
    @pt_session_log = build(:pt_session_log, user_id: @user.id).decorate
  end

  it "renders new pt_session_log form" do
    allow(view).to receive(:current_user).and_return(@user)
    render

    assert_select "form[action=?][method=?]", pt_session_logs_path, "post" do
      assert_select "select[name=?]", "pt_session_log[body_part_id]"

      # assert_select 'select[name=?]', /pt_session_log\[occurred_at\(\d+i\)\]/

      assert_select "textarea[name=?]", "pt_session_log[questions]"

      assert_select "textarea[name=?]", "pt_session_log[exercise_notes]"

      assert_select "textarea[name=?]", "pt_session_log[homework]"

      assert_select "input[name=?]", "pt_session_log[homework_exercise_ids][]"
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pain_logs/edit', type: :view do
  before(:each) do
    @user = create(:user)
    @body_part = create(:body_part)
    @pain = create(:pain)

    @pain_log = assign(:pain_log, PainLog.create!(
                                    user_id: @user.id,
                                    body_part_id: @body_part.id,
                                    pain_id: @pain.id,
                                    pain_level: 1,
                                    pain_description: 'MyText',
                                    trigger: 'MyText',
                                    datetime_occurred: Time.now
                                  ))
  end

  it 'renders the edit pain_log form' do
    allow(view).to receive(:current_user).and_return(@user)
    render

    assert_select 'form[action=?][method=?]', pain_log_path(@pain_log), 'post' do
      assert_select 'select[name=?]', 'pain_log[body_part_id]'

      assert_select 'input[name=?]', 'pain_log[pain_level]'

      assert_select 'textarea[name=?]', 'pain_log[pain_description]'

      assert_select 'textarea[name=?]', 'pain_log[trigger]'
    end
  end
end

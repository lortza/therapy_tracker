# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pt_sessions/new', type: :view do
  before(:each) do
    assign(:pt_session, PtSession.new(
                          user: nil,
                          exercise_notes: 'MyText',
                          homework: 'MyText',
                          duration: 1
                        ))
  end

  it 'renders new pt_session form' do
    render

    assert_select 'form[action=?][method=?]', pt_sessions_path, 'post' do
      assert_select 'input[name=?]', 'pt_session[user_id]'

      assert_select 'textarea[name=?]', 'pt_session[exercise_notes]'

      assert_select 'textarea[name=?]', 'pt_session[homework]'

      assert_select 'input[name=?]', 'pt_session[duration]'
    end
  end
end

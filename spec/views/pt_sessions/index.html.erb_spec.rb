# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pt_sessions/index', type: :view do
  before(:each) do
    assign(:pt_sessions, [
             PtSession.create!(
               user: nil,
               exercise_notes: 'MyText',
               homework: 'MyText',
               duration: 2
             ),
             PtSession.create!(
               user: nil,
               exercise_notes: 'MyText',
               homework: 'MyText',
               duration: 2
             ),
           ])
  end

  it 'renders a list of pt_sessions' do
    render
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
  end
end

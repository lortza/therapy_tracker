# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pt_sessions/show', type: :view do
  before(:each) do
    @pt_session = assign(:pt_session, PtSession.create!(
                                        user: nil,
                                        exercise_notes: 'MyText',
                                        homework: 'MyText',
                                        duration: 2
                                      ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
  end
end

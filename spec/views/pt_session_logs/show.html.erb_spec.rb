# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pt_session_logs/show', type: :view do
  before(:each) do
    @user = create(:user)
    @pt_session_log = create(:pt_session_log, user_id: @user.id)
  end

  it 'renders attributes in <div>' do
    allow(view).to receive(:current_user).and_return(@user)
    render
    expect(rendered).to match(%r{Mon 03/25/19 at 10:29PM})
    expect(rendered).to match(/Body Part\d+:/)
    expect(rendered).to match(/\d{2} minutes/)
    expect(rendered).to match(/sample question?/)
    expect(rendered).to match(/sample exercise notes/)
    expect(rendered).to match(/sample homework/)
  end
end

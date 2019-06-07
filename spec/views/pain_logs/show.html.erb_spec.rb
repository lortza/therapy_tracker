# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pain_logs/show', type: :view do
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

  it 'renders attributes in <p>' do
    allow(view).to receive(:current_user).and_return(@user)
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Body part/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end

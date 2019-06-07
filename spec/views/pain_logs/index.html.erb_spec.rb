# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pain_logs/index', type: :view do
  before(:each) do
    @user = create(:user)
    @body_part = create(:body_part)
    @pain = create(:pain)

    create(:pain_log, user_id: @user.id, body_part_id: @body_part.id, pain_id: @pain.id)
    create(:pain_log, user_id: @user.id, body_part_id: @body_part.id, pain_id: @pain.id)
    @logs = @user.pain_logs.paginate(page: params[:page], per_page: 25)
  end

  it 'renders a list of pain_logs' do
    render
    assert_select 'div.card-body>p', count: 2
  end
end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe "pain_logs/index", type: :view do
  before(:each) do
    @user = create(:user)
    create(:pain_log, user_id: @user.id)
    create(:pain_log, user_id: @user.id)
    logs = @user.pain_logs.order(occurred_at: "DESC").paginate(page: params[:page], per_page: 25)
    @logs = PainLogDecorator.decorate_collection(logs)
  end

  it "renders a list of pain_logs" do
    allow(view).to receive(:current_user).and_return(@user)
    render
    assert_select "div.card-body>p", count: 2
    assert_select "div.card-body>h5", text: "Pain: Mon 03/25/19 at 08:15PM", count: 2
    assert_select "div.card-body>p>strong", text: /Body Part\d+:/, count: 2
    assert_select "div.card-body>p", text: /Pain Level: \d /, count: 2
    assert_select "div.card-body>p", text: /sample pain description/, count: 2
    assert_select "div.card-body>p>small", text: "Triggered by: sample pain trigger", count: 2
  end
end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe "pains/index", type: :view do
  before(:each) do
    @user = create(:user)
    assign(:pains, [create(:pain, name: "Name1", user_id: @user.id),
      create(:pain, name: "Name2", user_id: @user.id)])
  end

  it "renders a list of pains" do
    allow(view).to receive(:current_user).and_return(@user)

    render
    assert_select "form"
    assert_select "h3>a", text: "Name1".to_s, count: 1
    assert_select "h3>a", text: "Name2".to_s, count: 1
  end
end

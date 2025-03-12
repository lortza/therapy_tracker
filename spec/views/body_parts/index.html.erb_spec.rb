# frozen_string_literal: true

require "rails_helper"

RSpec.describe "body_parts/index", type: :view do
  before(:each) do
    @user = create(:user)

    assign(:body_parts, [
      BodyPart.create!(
        user_id: @user.id,
        name: "Name1",
        archived: false
      ),
      BodyPart.create!(
        user_id: @user.id,
        name: "Name2",
        archived: false
      )
    ])
  end

  it "renders a list of body_parts" do
    allow(view).to receive(:current_user).and_return(@user)

    render
    assert_select "form"
    assert_select "h3>a", text: "Name1", count: 1
    assert_select "h3>a", text: "Name2", count: 1
  end
end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe "exercises/index", type: :view do
  before(:each) do
    @user = create(:user)
    assign(:exercises, [create(:exercise, user_id: @user.id, default_sets: 1, default_reps: 1, default_rep_length: 1),
      create(:exercise, user_id: @user.id, default_sets: 1, default_reps: 1, default_rep_length: 1)])
  end

  it "renders a list of exercises" do
    allow(view).to receive(:current_user).and_return(@user)

    render
    assert_select "form"
    assert_select "article>p>strong", text: "1 sets of 1 with 1 sec hold", count: 2
  end
end

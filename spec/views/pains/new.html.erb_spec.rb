# frozen_string_literal: true

require "rails_helper"

RSpec.describe "pains/new", type: :view do
  before(:each) do
    assign(:pain, build(:pain))
  end

  it "renders new pain form" do
    render

    assert_select "form[action=?][method=?]", pains_path, "post" do
      assert_select "input[name=?]", "pain[name]"
    end
  end
end

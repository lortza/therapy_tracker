# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "physical_therapy_sessions/new", type: :view do
  before(:each) do
    assign(:physical_therapy_session, PhysicalTherapySession.new(
      :user => nil,
      :exercise_notes => "MyText",
      :homework => "MyText",
      :duration => 1
    ))
  end

  it "renders new physical_therapy_session form" do
    render

    assert_select "form[action=?][method=?]", physical_therapy_sessions_path, "post" do

      assert_select "input[name=?]", "physical_therapy_session[user_id]"

      assert_select "textarea[name=?]", "physical_therapy_session[exercise_notes]"

      assert_select "textarea[name=?]", "physical_therapy_session[homework]"

      assert_select "input[name=?]", "physical_therapy_session[duration]"
    end
  end
end

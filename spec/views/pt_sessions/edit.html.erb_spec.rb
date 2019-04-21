# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "pt_sessions/edit", type: :view do
  before(:each) do
    @pt_session = assign(:pt_session, PtSession.create!(
      :user => nil,
      :exercise_notes => "MyText",
      :homework => "MyText",
      :duration => 1
    ))
  end

  it "renders the edit pt_session form" do
    render

    assert_select "form[action=?][method=?]", pt_session_path(@pt_session), "post" do

      assert_select "input[name=?]", "pt_session[user_id]"

      assert_select "textarea[name=?]", "pt_session[exercise_notes]"

      assert_select "textarea[name=?]", "pt_session[homework]"

      assert_select "input[name=?]", "pt_session[duration]"
    end
  end
end

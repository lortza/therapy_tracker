require 'rails_helper'

RSpec.describe "physical_therapy_sessions/index", type: :view do
  before(:each) do
    assign(:physical_therapy_sessions, [
      PhysicalTherapySession.create!(
        :user => nil,
        :exercise_notes => "MyText",
        :homework => "MyText",
        :duration => 2
      ),
      PhysicalTherapySession.create!(
        :user => nil,
        :exercise_notes => "MyText",
        :homework => "MyText",
        :duration => 2
      )
    ])
  end

  it "renders a list of physical_therapy_sessions" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end

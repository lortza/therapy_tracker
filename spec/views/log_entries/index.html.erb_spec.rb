require 'rails_helper'

RSpec.describe "log_entries/index", type: :view do
  before(:each) do
    assign(:log_entries, [
      LogEntry.create!(
        :sets => 2,
        :reps => 3,
        :exercise_name => "Exercise Name",
        :current_pain_level => 4,
        :current_pain_frequency => "Current Pain Frequency",
        :progress_note => "MyText"
      ),
      LogEntry.create!(
        :sets => 2,
        :reps => 3,
        :exercise_name => "Exercise Name",
        :current_pain_level => 4,
        :current_pain_frequency => "Current Pain Frequency",
        :progress_note => "MyText"
      )
    ])
  end

  it "renders a list of log_entries" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Exercise Name".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Current Pain Frequency".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end

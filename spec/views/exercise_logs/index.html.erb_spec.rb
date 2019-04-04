require 'rails_helper'

RSpec.describe "exercise_logs/index", type: :view do
  before(:each) do
    assign(:exercise_logs, [
      ExerciseLog.create!(
        :sets => 2,
        :reps => 3,
        :datetime_occurred => 'Sun, 24 Mar 2019 09:30:00 UTC +00:00',
        :body_part_id => 1,
        :current_pain_level => 4,
        :current_pain_frequency => "Current Pain Frequency",
        :progress_note => "MyText"
      ),
      ExerciseLog.create!(
        :sets => 2,
        :reps => 3,
        :datetime_occurred => 'Sun, 24 Mar 2019 09:30:00 UTC +00:00',
        :body_part_id => 1,
        :current_pain_level => 4,
        :current_pain_frequency => "Current Pain Frequency",
        :progress_note => "MyText"
      )
    ])
  end

  it "renders a list of exercise_logs" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Sun, 24 Mar 2019 09:30:00 UTC +00:00".to_s, :count => 2
    assert_select "tr>td", :text => "Body Part Name".to_s, :count => 2
    assert_select "tr>td", :text => "Exercise Name".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Current Pain Frequency".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end

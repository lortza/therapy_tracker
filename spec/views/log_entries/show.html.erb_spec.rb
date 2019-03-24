require 'rails_helper'

RSpec.describe "log_entries/show", type: :view do
  before(:each) do
    @log_entry = assign(:log_entry, LogEntry.create!(
      :datetime_exercised => 'Sun, 24 Mar 2019 09:30:00 UTC +00:00',
      :sets => 2,
      :reps => 3,
      :target_body_part => "Body Part Name",
      :exercise_name => "Exercise Name",
      :current_pain_level => 4,
      :current_pain_frequency => "Current Pain Frequency",
      :progress_note => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Body Part Name/)
    expect(rendered).to match(/Exercise Name/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Current Pain Frequency/)
    expect(rendered).to match(/MyText/)
  end
end

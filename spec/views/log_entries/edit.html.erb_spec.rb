require 'rails_helper'

RSpec.describe "log_entries/edit", type: :view do
  before(:each) do
    @log_entry = assign(:log_entry, LogEntry.create!(
      :datetime_exercised => 'Sun, 24 Mar 2019 09:30:00 UTC +00:00',
      :sets => 1,
      :reps => 1,
      :exercise_name => "MyString",
      :target_body_part => "Body Part Name",
      :current_pain_level => 1,
      :current_pain_frequency => "MyString",
      :progress_note => "MyText"
    ))
  end

  it "renders the edit log_entry form" do
    render

    assert_select "form[action=?][method=?]", log_entry_path(@log_entry), "post" do

      assert_select "input[name=?]", "log_entry[datetime_exercised]"

      assert_select "input[name=?]", "log_entry[sets]"

      assert_select "input[name=?]", "log_entry[reps]"

      assert_select "input[name=?]", "log_entry[exercise_name]"

      assert_select "input[name=?]", "log_entry[target_body_part]"

      assert_select "input[name=?]", "log_entry[current_pain_level]"

      assert_select "input[name=?]", "log_entry[current_pain_frequency]"

      assert_select "textarea[name=?]", "log_entry[progress_note]"
    end
  end
end

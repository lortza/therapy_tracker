require 'rails_helper'

RSpec.describe "log_entries/new", type: :view do
  before(:each) do
    assign(:log_entry, LogEntry.new(
      :sets => 1,
      :reps => 1,
      :exercise_name => "MyString",
      :current_pain_level => 1,
      :current_pain_frequency => "MyString",
      :progress_note => "MyText"
    ))
  end

  it "renders new log_entry form" do
    render

    assert_select "form[action=?][method=?]", log_entries_path, "post" do

      assert_select "input[name=?]", "log_entry[sets]"

      assert_select "input[name=?]", "log_entry[reps]"

      assert_select "input[name=?]", "log_entry[exercise_name]"

      assert_select "input[name=?]", "log_entry[current_pain_level]"

      assert_select "input[name=?]", "log_entry[current_pain_frequency]"

      assert_select "textarea[name=?]", "log_entry[progress_note]"
    end
  end
end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Pain log auto-fill", type: :system, js: true do
  let(:user) { create(:user) }
  let!(:body_part) { create(:body_part, user: user, name: "Knee") }
  let!(:pain_none) { create(:pain, user: user, name: "None") }
  let!(:pain_sharp) { create(:pain, user: user, name: "Sharp") }

  before do
    sign_in user
  end

  it "auto-fills pain level and description when 'None' is selected" do
    visit new_pain_log_path

    select "Knee", from: "pain_log[body_part_id]"
    select "None", from: "pain_log[pain_id]"

    # Verify the pain level is set to 0
    expect(page).to have_field("pain_log[pain_level]", with: "0")

    # Verify the description is set to 'none'
    expect(page).to have_field("pain_log[pain_description]", with: "none")

    # Verify the trigger field is focused (becomes the active element)
    trigger_field = find_field("pain_log[trigger]")
    expect(page.evaluate_script("document.activeElement.id")).to eq(trigger_field[:id])
  end

  it "does not auto-fill when other pain type is selected" do
    visit new_pain_log_path

    select "Knee", from: "pain_log[body_part_id]"

    # Fill in some values first
    fill_in "pain_log[pain_level]", with: "5"
    fill_in "pain_log[pain_description]", with: "sharp stabbing pain"

    # Select a different pain type
    select "Sharp", from: "pain_log[pain_id]"

    # Verify the values remain unchanged
    expect(page).to have_field("pain_log[pain_level]", with: "5")
    expect(page).to have_field("pain_log[pain_description]", with: "sharp stabbing pain")
  end
end

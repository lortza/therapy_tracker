# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Exercise rep counter", type: :system, js: true do
  let(:user) { create(:user) }
  let!(:body_part) { create(:body_part, user: user, name: "Shoulder") }
  let!(:exercise) { create(:exercise, user: user, name: "Push-ups") }
  let!(:exercise_log) do
    create(:exercise_log,
      user: user,
      body_part: body_part,
      exercise: exercise,
      sets: 2,
      reps: 3,
      rep_length: 1)
  end

  before do
    sign_in user
  end

  it "displays rep counter modal with Stimulus controller attributes" do
    visit exercise_log_path(exercise_log)

    # Verify the modal exists with Stimulus controller
    modal = find("#repCounterModal", visible: false)
    expect(modal["data-controller"]).to eq("exercise-counter")
    expect(modal["data-exercise-counter-sets-value"]).to eq("2")
    expect(modal["data-exercise-counter-reps-value"]).to eq("3")
    expect(modal["data-exercise-counter-rep-length-value"]).to eq("1")
  end

  it "displays start and stop buttons with correct Stimulus actions" do
    visit exercise_log_path(exercise_log)

    # Open the modal
    click_button "Launch Rep Counter"

    # Wait for modal to be visible
    expect(page).to have_css("#repCounterModal.show", wait: 2)

    # Verify start button has correct Stimulus attributes
    start_button = find("a", text: /Start Timer/)
    expect(start_button["data-exercise-counter-target"]).to eq("startButton")
    expect(start_button["data-action"]).to eq("click->exercise-counter#start")

    # Verify stop button has correct Stimulus attributes
    stop_button = find("a", text: /Stop & Reset/)
    expect(stop_button["data-exercise-counter-target"]).to eq("stopButton")
    expect(stop_button["data-action"]).to eq("click->exercise-counter#stop")
  end

  it "initializes counter displays to 0" do
    visit exercise_log_path(exercise_log)

    click_button "Launch Rep Counter"

    # Wait for modal
    expect(page).to have_css("#repCounterModal.show", wait: 2)

    # Verify initial display values
    set_display = find('[data-exercise-counter-target="setDisplay"]')
    rep_display = find('[data-exercise-counter-target="repDisplay"]')

    expect(set_display.text).to eq("0")
    expect(rep_display.text).to eq("0")
  end

  it "shows status indicator when counter starts", :skip_ci do
    # This test is skipped in CI because it requires real-time execution
    # and audio playback which can be flaky in CI environments
    visit exercise_log_path(exercise_log)

    click_button "Launch Rep Counter"
    expect(page).to have_css("#repCounterModal.show", wait: 2)

    # Click start
    click_link "Start Timer"

    # Wait a moment for the counter to start
    sleep 0.5

    # Verify status indicator becomes visible and shows "Begin!"
    status_indicator = find('[data-exercise-counter-target="statusIndicator"]')
    expect(status_indicator).not_to have_css(".hidden")
    expect(status_indicator.text).to eq("Begin!")
  end

  it "can stop the counter", :skip_ci do
    # This test is skipped in CI because it requires real-time execution
    visit exercise_log_path(exercise_log)

    click_button "Launch Rep Counter"
    expect(page).to have_css("#repCounterModal.show", wait: 2)

    # Start the counter
    click_link "Start Timer"
    sleep 0.5

    # Stop the counter - it navigates to the destination URL
    stop_link = find("a", text: /Stop & Reset/)
    destination = stop_link[:href]

    click_link "Stop & Reset"

    # Should navigate to the destination URL (logs path)
    expect(page).to have_current_path(destination, wait: 2)
  end
end

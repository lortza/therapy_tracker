# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Exercise log deletion", type: :system, js: true do
  let(:user) { create(:user) }
  let!(:body_part) { create(:body_part, user: user, name: "Shoulder") }
  let!(:exercise) { create(:exercise, user: user, name: "Push-ups") }
  let!(:exercise_log) do
    create(:exercise_log,
      user: user,
      body_part: body_part,
      exercise: exercise,
      sets: 3,
      reps: 10,
      progress_note: "test exercise")
  end

  before do
    sign_in user
  end

  it "successfully deletes an exercise log from the edit page" do
    visit edit_exercise_log_path(exercise_log)

    # Open the danger zone details
    find("summary", text: "Danger Zone").click

    # Verify the delete link is present with correct Turbo attributes
    delete_link = find("a", text: /Click to delete/)
    expect(delete_link["data-turbo-method"]).to eq("delete")
    expect(delete_link["data-turbo-confirm"]).to be_present

    # Click delete and accept confirmation
    expect {
      accept_confirm do
        delete_link.click
      end
      # Wait for redirect to complete
      expect(page).to have_current_path(root_path)
    }.to change(ExerciseLog, :count).by(-1)

    # Verify the exercise log no longer exists
    expect(ExerciseLog.find_by(id: exercise_log.id)).to be_nil
  end

  it "does not delete when canceling the confirmation dialog" do
    visit edit_exercise_log_path(exercise_log)

    find("summary", text: "Danger Zone").click

    expect {
      dismiss_confirm do
        find("a", text: /Click to delete/).click
      end
      sleep 0.1
    }.not_to change(ExerciseLog, :count)

    expect(page).to have_current_path(edit_exercise_log_path(exercise_log))
  end
end

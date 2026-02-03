# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Pain log deletion", type: :system, js: true do
  let(:user) { create(:user) }
  let!(:body_part) { create(:body_part, user: user, name: "Knee") }
  let!(:pain) { create(:pain, user: user, name: "Sharp") }
  let!(:pain_log) do
    create(:pain_log,
      user: user,
      body_part: body_part,
      pain: pain,
      pain_level: 5,
      pain_description: "test pain")
  end

  before do
    sign_in user
  end

  it "successfully deletes a pain log from the edit page" do
    visit edit_pain_log_path(pain_log)

    # Open the danger zone details (it's a summary element)
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
    }.to change(PainLog, :count).by(-1)

    # Verify the pain log no longer exists
    expect(PainLog.find_by(id: pain_log.id)).to be_nil
  end

  it "does not delete when canceling the confirmation dialog" do
    visit edit_pain_log_path(pain_log)

    find("summary", text: "Danger Zone").click

    expect {
      dismiss_confirm do
        find("a", text: /Click to delete/).click
      end
      # Give time for any potential action to occur
      sleep 0.1
    }.not_to change(PainLog, :count)

    # Should still be on edit page
    expect(page).to have_current_path(edit_pain_log_path(pain_log))
  end
end

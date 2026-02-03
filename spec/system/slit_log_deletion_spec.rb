# frozen_string_literal: true

require "rails_helper"

RSpec.describe "SLIT log deletion", type: :system, js: true do
  let(:user) { create(:user, enable_slit_tracking: true) }
  let!(:slit_log) do
    create(:slit_log,
      user: user,
      occurred_at: 1.day.ago,
      started_new_bottle: false,
      doses_remaining: 10)
  end

  before do
    sign_in user
  end

  it "successfully deletes a slit log from the edit page" do
    visit edit_slit_log_path(slit_log)

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
    }.to change(SlitLog, :count).by(-1)

    # Verify the slit log no longer exists
    expect(SlitLog.find_by(id: slit_log.id)).to be_nil
  end

  it "does not delete when canceling the confirmation dialog" do
    visit edit_slit_log_path(slit_log)

    find("summary", text: "Danger Zone").click

    expect {
      dismiss_confirm do
        find("a", text: /Click to delete/).click
      end
      # Give time for any potential action to occur
      sleep 0.1
    }.not_to change(SlitLog, :count)

    # Should still be on edit page
    expect(page).to have_current_path(edit_slit_log_path(slit_log))
  end
end

# frozen_string_literal: true

require "rails_helper"

describe "User creates a Cat" do
  it "successfully" do
    cat_name = 'Cat 1'
    user = create(:user)

    sign_in(user)
    visit new_cat_path
    fill_in "Name", with: cat_name
    click_on "Create Cat"

    expect(page).to have_content("Cat was successfully created")
  end

  it "with a name that's already taken" do
    cat1 = create(:cat)
    user = create(:user)

    sign_in(user)
    
    visit new_cat_path
    fill_in "Name", with: cat1.name
    click_on "Create Cat"

    expect(page).to have_content("Name has already been taken")
  end
end

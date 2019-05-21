# frozen_string_literal: true

require 'rails_helper'

xdescribe 'User creates an Exercise' do
  it 'successfully' do
    visit new_exercise_path

    exercise_name = 'ex1'
    fill_in 'exercise[name]', with: exercise_name
    click_on 'commit'

    expect(page).to have_content(exercise_name)
  end
end

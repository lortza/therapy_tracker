# frozen_string_literal: true

require 'rails_helper'

describe 'User creates an Exercise Log' do
  it 'successfully' do
    user = create(:user)
    exercise_name = 'ex1'
    body_part_name = 'bp1'
    create(:exercise, user_id: user.id, name: exercise_name)
    create(:body_part, user_id: user.id, name: body_part_name)

    sign_in(user)
    visit new_exercise_log_path

    select body_part_name, from: 'exercise_log[body_part_id]'
    select exercise_name, from: 'exercise_log[exercise_id]'

    fill_in 'exercise_log[sets]', with: 1
    fill_in 'exercise_log[reps]', with: 1
    fill_in 'exercise_log[rep_length]', with: 1

    click_on 'Create Exercise log'

    expect(page).to have_content(/ex1/i)
  end

  it 'prepopulates the sets/reps/rep_length/per_side fields', js: true do
    user = create(:user)
    exercise_name = 'ex1'
    exercise = create(:exercise,
                      user_id: user.id,
                      name: exercise_name,
                      default_sets: 1,
                      default_reps: 1,
                      default_rep_length: 1,
                      default_per_side: true)

    sign_in(user)
    visit new_exercise_log_path
    select exercise_name, from: 'exercise_log[exercise_id]'
    sets = find('#exercise_log_sets').value.to_i
    reps = find('#exercise_log_reps').value.to_i
    rep_length = find('#exercise_log_rep_length').value.to_i
    per_side = find('#exercise_log_per_side').value

    expect(sets).to eq(exercise.default_sets)
    expect(reps).to eq(exercise.default_reps)
    expect(rep_length).to eq(exercise.default_rep_length)
    expect(per_side).to eq('1')
  end
end

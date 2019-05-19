# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'exercises/edit', type: :view do
  before(:each) do
    @exercise = assign(:exercise, Exercise.create!(
                                    user: nil,
                                    name: 'MyString',
                                    description: 'MyText'
                                  ))
  end

  it 'renders the edit exercise form' do
    render

    assert_select 'form[action=?][method=?]', exercise_path(@exercise), 'post' do
      assert_select 'input[name=?]', 'exercise[user_id]'

      assert_select 'input[name=?]', 'exercise[name]'

      assert_select 'textarea[name=?]', 'exercise[description]'
    end
  end
end

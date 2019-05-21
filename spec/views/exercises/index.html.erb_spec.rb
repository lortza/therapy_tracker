# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'exercises/index', type: :view do
  before(:each) do
    assign(:exercises, [create(:exercise, default_sets: 1, default_reps: 1, default_rep_length: 1),
                        create(:exercise, default_sets: 1, default_reps: 1, default_rep_length: 1),])
  end

  it 'renders a list of exercises' do
    render
    assert_select 'article>p>strong', text: '1 sets of 1 with 1 sec hold'.to_s, count: 2
  end
end

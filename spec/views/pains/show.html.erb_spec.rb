# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pains/show', type: :view do
  before(:each) do
    @pain = assign(:pain, Pain.create!(
                            name: 'Name'
                          ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
  end
end

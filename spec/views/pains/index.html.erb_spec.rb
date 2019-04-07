# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "pains/index", type: :view do
  before(:each) do
    assign(:pains, [
      Pain.create!(
        :name => "Name"
      ),
      Pain.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of pains" do
    render
    assert_select 'tr>td', :text => "Name".to_s, count: 2
  end
end

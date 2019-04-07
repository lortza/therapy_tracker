# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "exercises/index", type: :view do
  before(:each) do
    assign(:exercises, [
      Exercise.create!(
        :user => nil,
        :name => "Name",
        :description => "MyText"
      ),
      Exercise.create!(
        :user => nil,
        :name => "Name",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of exercises" do
    render
    assert_select 'tr>td', :text => nil.to_s, count: 2
    assert_select 'tr>td', :text => "Name".to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "body_parts/index", type: :view do
  before(:each) do
    assign(:body_parts, [
      BodyPart.create!(
        :name => "Name"
      ),
      BodyPart.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of body_parts" do
    render
    assert_select 'tr>td', :text => "Name".to_s, count: 2
  end
end

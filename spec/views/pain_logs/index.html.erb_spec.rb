# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "pain_logs/index", type: :view do
  before(:each) do
    assign(:pain_logs, [
      PainLog.create!(
        :user => nil,
        :body_part_id => 1,
        :pain_level => 2,
        :pain_description => "MyText",
        :trigger => "MyText"
      ),
      PainLog.create!(
        :user => nil,
        :body_part_id => 1,
        :pain_level => 2,
        :pain_description => "MyText",
        :trigger => "MyText"
      )
    ])
  end

  it "renders a list of pain_logs" do
    render
    assert_select 'tr>td', :text => nil.to_s, count: 2
    assert_select 'tr>td', :text => "Target Body Part".to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
  end
end

require 'rails_helper'

RSpec.describe "pain_logs/show", type: :view do
  before(:each) do
    @pain_log = assign(:pain_log, PainLog.create!(
      :user => nil,
      :body_part_id => 1,
      :pain_level => 2,
      :pain_description => "MyText",
      :trigger => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Target Body Part/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end

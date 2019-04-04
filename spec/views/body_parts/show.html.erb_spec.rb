require 'rails_helper'

RSpec.describe "body_parts/show", type: :view do
  before(:each) do
    @body_part = assign(:body_part, BodyPart.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end

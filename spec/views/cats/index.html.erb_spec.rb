require 'rails_helper'

RSpec.describe "cats/index", type: :view do
  before(:each) do
    assign(:cats,
      create_list(:cat, 2)
    )
  end

  it "renders a list of cats" do
    render
    # assert_select "tr>td", :text => "Cat".to_s, :count => 2
    expect(rendered).to match(/Cat.*/)
  end
end

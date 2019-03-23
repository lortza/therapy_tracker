require 'rails_helper'

RSpec.describe "cats/show", type: :view do
  before(:each) do
    @cat = assign(:cat, Cat.create!(
      :name => "Cat 1"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Cat 1/)
  end
end

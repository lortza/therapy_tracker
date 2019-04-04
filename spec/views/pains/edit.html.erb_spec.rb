require 'rails_helper'

RSpec.describe "pains/edit", type: :view do
  before(:each) do
    @pain = assign(:pain, Pain.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit pain form" do
    render

    assert_select "form[action=?][method=?]", pain_path(@pain), "post" do

      assert_select "input[name=?]", "pain[name]"
    end
  end
end

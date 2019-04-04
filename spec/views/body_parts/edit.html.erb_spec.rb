require 'rails_helper'

RSpec.describe "body_parts/edit", type: :view do
  before(:each) do
    @body_part = assign(:body_part, BodyPart.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit body_part form" do
    render

    assert_select "form[action=?][method=?]", body_part_path(@body_part), "post" do

      assert_select "input[name=?]", "body_part[name]"
    end
  end
end

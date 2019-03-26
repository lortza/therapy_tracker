require 'rails_helper'

RSpec.describe "exercises/new", type: :view do
  before(:each) do
    assign(:exercise, Exercise.new(
      :user => nil,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new exercise form" do
    render

    assert_select "form[action=?][method=?]", exercises_path, "post" do

      assert_select "input[name=?]", "exercise[user_id]"

      assert_select "input[name=?]", "exercise[name]"

      assert_select "textarea[name=?]", "exercise[description]"
    end
  end
end

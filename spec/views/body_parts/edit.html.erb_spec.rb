# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'body_parts/edit', type: :view do
  before(:each) do
    @user = create(:user)
    @body_part = assign(:body_part, BodyPart.create!(
                                      user_id: @user.id,
                                      name: 'MyString',
                                      archived: false
                                    ))
  end

  it 'renders the edit body_part form' do
    render

    assert_select 'form[action=?][method=?]', body_part_path(@body_part), 'post' do
      assert_select 'input[name=?]', 'body_part[name]'
      assert_select 'input[name=?]', 'body_part[archived]'
    end
  end
end

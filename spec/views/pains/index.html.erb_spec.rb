# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pains/index', type: :view do
  before(:each) do
    user = create(:user)
    assign(:pains, [create(:pain, name: 'Name', user_id: user.id),
                    create(:pain, name: 'Name', user_id: user.id),])
  end

  it 'renders a list of pains' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
  end
end

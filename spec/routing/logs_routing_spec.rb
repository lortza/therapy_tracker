# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LogsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/logs').to route_to('logs#index')
    end
  end
end

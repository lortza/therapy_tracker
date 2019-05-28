# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReportsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/reports').to route_to('reports#index')
    end
  end
end

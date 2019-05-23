# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReportsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/reports').to route_to('reports#index')
    end

    it 'routes to #past_week' do
      expect(get: '/reports/past_week').to route_to('reports#past_week')
    end

    it 'routes to #past_two_weeks' do
      expect(get: '/reports/past_two_weeks').to route_to('reports#past_two_weeks')
    end
  end
end

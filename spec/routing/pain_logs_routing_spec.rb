# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PainLogsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/pain_logs').to route_to('pain_logs#index')
    end

    it 'routes to #new' do
      expect(get: '/pain_logs/new').to route_to('pain_logs#new')
    end

    it 'routes to #show' do
      expect(get: '/pain_logs/1').to route_to('pain_logs#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/pain_logs/1/edit').to route_to('pain_logs#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/pain_logs').to route_to('pain_logs#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/pain_logs/1').to route_to('pain_logs#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/pain_logs/1').to route_to('pain_logs#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/pain_logs/1').to route_to('pain_logs#destroy', id: '1')
    end
  end
end

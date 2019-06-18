# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PtSessionLogsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/pt_session_logs').to route_to('pt_session_logs#index')
    end

    it 'routes to #new' do
      expect(get: '/pt_session_logs/new').to route_to('pt_session_logs#new')
    end

    it 'routes to #show' do
      expect(get: '/pt_session_logs/1').to route_to('pt_session_logs#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/pt_session_logs/1/edit').to route_to('pt_session_logs#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/pt_session_logs').to route_to('pt_session_logs#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/pt_session_logs/1').to route_to('pt_session_logs#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/pt_session_logs/1').to route_to('pt_session_logs#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/pt_session_logs/1').to route_to('pt_session_logs#destroy', id: '1')
    end
  end
end

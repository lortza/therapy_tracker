# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PainsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/pains').to route_to('pains#index')
    end

    it 'routes to #new' do
      expect(get: '/pains/new').to route_to('pains#new')
    end

    it 'routes to #show' do
      expect(get: '/pains/1').to route_to('pains#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/pains/1/edit').to route_to('pains#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/pains').to route_to('pains#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/pains/1').to route_to('pains#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/pains/1').to route_to('pains#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/pains/1').to route_to('pains#destroy', id: '1')
    end
  end
end

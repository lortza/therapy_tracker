# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BodyPartsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/body_parts').to route_to('body_parts#index')
    end

    it 'routes to #new' do
      expect(get: '/body_parts/new').to route_to('body_parts#new')
    end

    it 'routes to #edit' do
      expect(get: '/body_parts/1/edit').to route_to('body_parts#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/body_parts').to route_to('body_parts#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/body_parts/1').to route_to('body_parts#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/body_parts/1').to route_to('body_parts#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/body_parts/1').to route_to('body_parts#destroy', id: '1')
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExercisesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/exercises').to route_to('exercises#index')
    end

    it 'routes to #new' do
      expect(get: '/exercises/new').to route_to('exercises#new')
    end

    it 'routes to #show' do
      expect(get: '/exercises/1').to route_to('exercises#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/exercises/1/edit').to route_to('exercises#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/exercises').to route_to('exercises#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/exercises/1').to route_to('exercises#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/exercises/1').to route_to('exercises#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/exercises/1').to route_to('exercises#destroy', id: '1')
    end
  end
end

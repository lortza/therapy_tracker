# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PainLogQuickFormValuesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/pain_log_quick_form_values').to route_to('pain_log_quick_form_values#index')
    end

    it 'routes to #new' do
      expect(get: '/pain_log_quick_form_values/new').to route_to('pain_log_quick_form_values#new')
    end

    it 'routes to #edit' do
      expect(get: '/pain_log_quick_form_values/1/edit').to route_to('pain_log_quick_form_values#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/pain_log_quick_form_values').to route_to('pain_log_quick_form_values#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/pain_log_quick_form_values/1').to route_to('pain_log_quick_form_values#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/pain_log_quick_form_values/1').to route_to('pain_log_quick_form_values#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/pain_log_quick_form_values/1').to route_to('pain_log_quick_form_values#destroy', id: '1')
    end
  end
end

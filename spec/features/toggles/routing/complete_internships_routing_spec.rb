# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CompleteInternshipsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/complete_internships')
        .to route_to('complete_internships#index')
    end

    it 'routes to #new' do
      expect(get: '/complete_internships/new')
        .to route_to('complete_internships#new')
    end

    it 'routes to #show' do
      expect(get: '/complete_internships/1')
        .to route_to('complete_internships#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/complete_internships/1/edit')
        .to route_to('complete_internships#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/complete_internships')
        .to route_to('complete_internships#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/complete_internships/1')
        .to route_to('complete_internships#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/complete_internships/1')
        .to route_to('complete_internships#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/complete_internships/1')
        .to route_to('complete_internships#destroy', id: '1')
    end
  end
end

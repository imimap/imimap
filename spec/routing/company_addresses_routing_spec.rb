# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CompanyAddressesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/company_addresses').to route_to('company_addresses#index')
    end

    it 'routes to #new' do
      expect(get: '/company_addresses/new').to route_to('company_addresses#new')
    end

    it 'routes to #show' do
      expect(get: '/company_addresses/1').to route_to('company_addresses#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/company_addresses/1/edit').to route_to('company_addresses#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/company_addresses').to route_to('company_addresses#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/company_addresses/1').to route_to('company_addresses#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/company_addresses/1').to route_to('company_addresses#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/company_addresses/1').to route_to('company_addresses#destroy', id: '1')
    end
  end
end

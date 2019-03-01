# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapsHelper, type: :helper do
  it 'generates data for leaflet' do
    cas = [ca1 = create(:company_address_1), ca2 = create(:company_address_2)]
    json = helper.company_locations_json(company_addresses: cas)
    expect(json).to include(ca1.city)
    expect(json).to include(ca2.city)
  end
end

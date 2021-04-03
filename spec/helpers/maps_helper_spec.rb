# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapsHelper, type: :helper do
  it 'generates data for leaflet' do
    @internship = create(:internship)
    # cas = [ca1 = create(:company_address01), ca2 = create(:company_address02)]
    cas =
      Internship.joins(:company_address)
                .where.not(company_addresses: { latitude: nil })
                .pluck(:city, :country, :latitude, :longitude)
    json = helper.company_locations_json(company_locations: cas)
    expect(json).to include(@internship.company_address.city)
  end
end

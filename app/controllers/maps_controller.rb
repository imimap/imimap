# frozen_string_literal: true

# Controller for all map views
class MapsController < ApplicationController
  skip_authorization_check only: [:start_page]
  include MapsHelper
  def start_page
    @map_view = true
    @company_addresses = CompanyAddress.where.not(latitude: nil)
    @company_location_json = company_locations_json(company_addresses: @company_addresses)
  end

  def debug; end
end

# frozen_string_literal: true

# Controller for all map views
class MapsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:peek_preview]
  skip_authorization_check only: [:peek_preview]
  include MapsHelper

  def peek_preview
    @map_view = true
    @company_addresses = []
    @zoom = 3
    @company_location_json = company_locations_json(company_addresses: @company_addresses)
    render :map_view
  end

  def map_view
    authorize! :map_cities, Internship
    @map_view = true
    @zoom = 3
    @company_addresses = Internship.current_addresses
    @company_location_json = company_locations_json(company_addresses: @company_addresses)
  end
end

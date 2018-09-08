# frozen_string_literal: true

# Controller for all map views
class MapsController < ApplicationController
  skip_authorization_check only: [:peek_preview]
  include MapsHelper

  def peek_preview
    @map_view = true
    @company_addresses = CompanyAddress.where.not(latitude: nil)
    @company_location_json = company_locations_json(company_addresses: @company_addresses)
    render :start_page
  end

  def start_page
    @map_view = true
    @company_addresses = CompanyAddress.where.not(latitude: nil)
    @company_location_json = company_locations_json(company_addresses: @company_addresses)
  end

  def debug; end
end

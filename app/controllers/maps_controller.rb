# frozen_string_literal: true

# Controller for all map views
class MapsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:peek_preview]
  skip_authorization_check only: [:peek_preview]
  include MapsHelper

  def peek_preview
    @map_view = true
    @company_addresses = []
    @zoom = 11
    @company_location_json =
      company_locations_json(company_addresses: @company_addresses)
    render :map_view
  end

  def map_view
    authorize! :map_cities, Internship
    @map_view = true
    @zoom = 3
    @company_addresses =
      Internship.joins(:company_address)
                .where(semester: Semester.current.previous)
                .where.not(company_addresses: { latitude: nil })
    # CompanyAddress.where.not(latitude: nil)
    @company_location_json =
      company_locations_json(company_addresses: @company_addresses)
  end
end

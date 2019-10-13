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
      company_locations_json(company_locations: @company_addresses)
    render :map_view
  end

  def map_view
    authorize! :map_cities, Internship
    @map_view = true
    @zoom = 3
    if can? :map_internships, Internship
      map_view_full_internships
    else
      map_view_only_locations
    end
  end

  def map_view_only_locations
    internships =
      Internship.joins(:company_address)
                .where(semester: Semester.current)
                .where.not(company_addresses: { latitude: nil })
                .pluck(:city, :country, :latitude, :longitude)

    @company_location_json = company_locations_json(company_locations: internships)
  end

  def map_view_full_internships
    internships =
      Internship.joins(company_address: [:company],
                       complete_internship: [:student])
                .pluck(:first_name, :last_name,
                       :name, 'company_addresses.city', :country,
                       :latitude, :longitude)

    @company_location_json = internships_json(internships: internships)
   end
end

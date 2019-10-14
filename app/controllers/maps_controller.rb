# frozen_string_literal: true

# Controller for all map views
class MapsController < ApplicationController
  include ApplicationHelper
  include MapsHelper
  include CompleteInternshipsHelper

  skip_before_action :authenticate_user!, only: [:peek_preview]
  skip_authorization_check only: [:peek_preview]
  before_action :set_semesters

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
    if params['semester_id'] != '-1'
      internships = internships.where(semester: @semester)
    end
    internships = internships.where.not(company_addresses: { latitude: nil })
                             .pluck(:city, :country, :latitude, :longitude)
    @company_location_json = company_locations_json(
      company_locations: internships
    )
  end

  def map_view_full_internships
    internships =
      Internship.joins(company_address: [:company],
                       complete_internship: [:student])
    if params['semester_id'] != '-1'
      internships = internships.where(semester: @semester)
    end
    internships = internships.pluck(:first_name, :last_name,
                                    :name, 'company_addresses.city', :country,
                                    :latitude, :longitude, 'internships.id')

    @company_location_json = internships_json(internships: internships)
  end

  private

  def set_semesters
    @semester_options = semester_select_options(show_all: true)
    @semester = semester_from_params(params)
  end
end

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
    internships = select_semester(internships)
    internships = internships.where.not(company_addresses: { latitude: nil })
                             .pluck(:city, :country, :latitude, :longitude)
    @company_location_json = company_locations_json(
      company_locations: internships
    )
  end

  def map_view_full_internships
    internships =
      Internship.joins(:semester, company_address: [:company],
                                  complete_internship: [:student])
    internships = select_semester(internships)

    internships = internships.pluck(*full_internship_view_attribute_list)

    @company_location_json =
      internships_json(internships: internships,
                       all_semester: @semester_options_all)
  end

  private

  def full_internship_view_attribute_list
    [:first_name, :last_name,
     'companies.name',
     'company_addresses.city',
     :country,
     :latitude, :longitude,
     'semesters.name',
     'internships.id']
  end

  def set_semesters
    @semester_options = semester_select_options(show_all: true)
    @semester = semester_from_params(params)
    @semester_options_all = params['semester_id'] == '-1'
  end

  def select_semester(internships)
    if @semester_options_all
      internships
    else
      internships.where(semester: @semester)
    end
  end
end

# frozen_string_literal: true

# Controller
class SearchesController < InheritedResources::Base
  include ApplicationHelper
  include MapsHelper
  include SearchesHelper
  load_and_authorize_resource

  before_action :set_programming_languages,
                only: %i[start_search show_results confirm_results shuffle
                         no_more_results]
  before_action :set_locations,
                only: %i[start_search show_results confirm_results shuffle
                         no_more_results]
  before_action :set_previous_results,
                only: %i[start_search show_results confirm_results shuffle
                         no_more_results]
  before_action :search_params, only: %i[show_results confirm_results]
  before_action :searched_before, only: %i[show_results confirm_results]

  def start_search
    @search = Search.new
    @internship_limit = UserCanSeeInternship.limit
    map_results(@previous_results)
  end

  def show_results
    create_search_from_params
    @results = collect_results
    @results = pick_random_results(@results)
    set_previous_results
    map_results(@previous_results)
  end

  def confirm_results
    create_search_from_params
    @results = collect_results
    @internship_limit = UserCanSeeInternship.limit

    return if @results.count > (@internship_limit / 2)

    redirect_to action: 'show_results', search: params[:search].to_unsafe_h
  end

  def shuffle
    pick_random_internship
    @results = show_one_random_result(@results)
    map_results(@results)
    render 'searches/show_results'
  end

  def no_more_results
    pick_random_internship
    return if UserCanSeeInternship
              .previous_associated_internships(user: current_user).count == 12

    @results = show_one_random_result(@results)
    map_results(@results)
    render 'searches/show_results'
  end

  private

  def search_params
    params.require(:search).permit(permitted_params)
  end

  def permitted_params
    %i[search]
  end

  def collect_cities
    Internship.includes(:company_address).pluck(:city).uniq
              .reject(&:nil?).reject(&:empty?).sort
  end

  def collect_countries
    address_ids = Internship.pluck(:company_address_id).reject(&:nil?)
    addresses = CompanyAddress.where(id: address_ids)
    countries = addresses.map(&:country_name).uniq.sort
    countries
  end

  def concat_countries_cities
    cities = collect_cities
    countries = collect_countries
    if countries
      countries.concat(['------'], cities)
    elsif cities
      cities
    else
      ['no locations']
    end
  end

  def set_programming_languages
    @programming_languages = ProgrammingLanguage.pluck(:name, :id)
  end

  def set_locations
    @locations = concat_countries_cities
  end

  def set_previous_results
    @previous_results = UserCanSeeInternship
                        .previous_associated_internships(user: current_user)
  end

  def map_results(internships)
    return internships unless internships

    @zoom = 11
    @map_view = true
    @map_r = Internship.where(id: internships.map(&:id)).joins(:company_address)
    @full_internships = get_info(@map_r).to_json.html_safe
    @map_r = @map_r.where.not(company_addresses: { latitude: nil })
                   .pluck(:city, :country, :latitude, :longitude)
    @company_location_json = company_locations_json(
      company_locations: @map_r
    )
  end

  def get_info(internships)
    return internships unless internships

    @full_internships = []
    internships.each do |i|
      @full_internships.push([i.company_address.try(:company).try(:name),
                              i.try(:orientation).try(:name)])
    end
    @full_internships
  end

  def create_search_from_params
    @search =
      Search
      .new(paid: params[:search][:paid],
           location: params[:search][:location],
           orientation_id: params[:search][:orientation_id],
           programming_language_id: params[:search][:programming_language_id])
  end

  def searched_before
    @searched_before = !params[:search].nil?
  end
end

# frozen_string_literal: true

# Controller
class SearchesController < InheritedResources::Base
  include SearchesHelper
  load_and_authorize_resource

  before_action :set_programming_languages,
                only: %i[start_search show_results confirm_results shuffle]
  before_action :set_locations,
                only: %i[start_search show_results confirm_results shuffle]
  before_action :search_params, only: %i[show_results confirm_results]

  def start_search
    @search = Search.new
    @internship_limit = UserCanSeeInternship.limit
    @previous_results =
      UserCanSeeInternship.previous_associated_internships(user: current_user)
  end

  def show_results
    create_search_from_params
    @results = collect_results
    @too_many_results = @results.count >= UserCanSeeInternship.limit
    @results = pick_random_results(@results)
  end

  def confirm_results
    create_search_from_params
    @results = collect_results
    @internship_limit = UserCanSeeInternship.limit

    return if @results.count > (@internship_limit / 2)

    redirect_to action: 'show_results', search: params[:search].to_unsafe_h
  end

  def shuffle
    # create_search_from_params
    internships = Internship.all.shuffle
    @results = Array.new(1,internships[0])
    @search =
      Search
      .new()

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

  def create_search_from_params
    @search =
      Search
      .new(paid: params[:search][:paid],
           location: params[:search][:location],
           orientation_id: params[:search][:orientation_id],
           programming_language_id: params[:search][:programming_language_id])
  end
end

# frozen_string_literal: true

# Controller
class SearchesController < InheritedResources::Base
  include SearchesHelper
  load_and_authorize_resource

  before_action :set_programming_languages, only: %i[start_search show_results]
  before_action :set_locations, only: %i[start_search show_results]

  def start_search
    @search = Search.new
    @internship_limit = UserCanSeeInternship.limit
  end

  def show_results
    create_search_from_params
    @results = collect_results
    render 'show_results'
  end

  private

  def search_params
    params.require(:search).permit
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
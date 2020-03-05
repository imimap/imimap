# frozen_string_literal: true

# Controller
class SearchesController < InheritedResources::Base
  include SearchesHelper
  load_and_authorize_resource

  before_action :set_programming_languages, only: %i[start_search show_results]
  before_action :set_locations, only: %i[start_search show_results]

  def start_search
    @search = Search.new
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
    cities = Internship.all
                       .map { |i| i.company_address.try(:city) }
                       .reject(&:nil?).reject(&:empty?)
    return if cities.nil?

    cities.uniq.sort
  end

  def collect_countries
    countries = Internship.all
                          .map { |i| i.company_address.try(:country_name) }
                          .reject(&:nil?).reject(&:empty?)
    return if countries.nil?

    countries.uniq.sort
  end

  def concat_countries_cities
    cities = collect_cities
    countries = collect_countries
    if cities
      cities.concat(['------'], collect_countries)
    elsif countries
      collect_countries
    else
      ['no locations']
    end
  end

  def set_programming_languages
    @programming_languages = ProgrammingLanguage.all.pluck(:name, :id)
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

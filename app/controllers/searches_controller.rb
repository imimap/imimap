# frozen_string_literal: true

# Controller
class SearchesController < InheritedResources::Base
  load_and_authorize_resource

  def start_search
    @search = Search.new
    @programming_languages = ProgrammingLanguage.all.pluck(:name, :id)
    @locations = concat_countries_cities
  end

  private

  def search_params
    params.require(:search).permit
  end

  def collect_cities
    cities = Internship.all
                       .map { |i| i.company_address.try(:city) }
                       .reject!(&:nil?)
    return if cities.nil?

    cities.uniq.sort
  end

  def collect_countries
    countries = Internship.all
                          .map { |i| i.company_address.try(:country) }
                          .reject!(&:nil?)
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
end

# frozen_string_literal: true

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
    Internship.all.map { |i| i.company_address.try(:city) }
              .reject!(&:nil?).uniq.sort
  end

  def collect_countries
    Internship.all.map { |i| i.company_address.try(:country) }
              .reject!(&:nil?).uniq.sort
  end

  def concat_countries_cities
    collect_cities.concat(['------'], collect_countries)
  end
end

# frozen_string_literal: true

# Controller
class SearchesController < InheritedResources::Base
  load_and_authorize_resource

  before_action :set_programming_languages, only: %i[start_search show_results]
  before_action :set_locations, only: %i[start_search show_results]

  def start_search
    @search = Search.new
  end

  def show_results
    @search =
      Search
      .new(paid: params[:search][:paid],
           location: params[:search][:location],
           orientation_id: params[:search][:orientation_id],
           programming_language_id: params[:search][:programming_language_id])
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

  def filter_paid(internships)
    return internships unless @search.paid.nil?

    return internships unless internships

    if @search.paid == true
      # i.payment_state_id == 2 => "cash benefit"
      internships = internships.select do |i|
        i.payment_state_id == 2 || i.salary.try(:positive?)
      end
    elsif @search.paid == false
      internships = internships.select do |i|
        i.payment_state_id != 2 && (i.salary.nil? || i.salary <= 0)
      end
    end
    internships
  end

  def filter_location(internships)
    loc = @search.location
    return internships unless loc
    return internships if loc.empty?

    return internships unless internships

    internships = internships.select do |i|
      i.company_address.try(:city) == loc || i.company_address.try(:country) == loc
    end
    internships
  end

  def filter_orientation_id(internships)
    return internships unless @search.orientation_id

    return internships unless internships

    internships = internships.select do |i|
      i.orientation_id == @search.orientation_id
    end
    internships
  end

  def filter_pl(internships)
    return internships unless @search.programming_language_id

    return internships unless internships

    internships = internships.select do |i|
      i.programming_language_ids.include?(@search.programming_language_id)
    end
    internships
  end

  def sort_results(internships)
    return internships unless internships

    internships = internships.sort_by do |i|
      if i.start_date.nil?
        Date.new(1990, 1, 1)
      else
        i.start_date
      end
    end
    internships = internships.reverse
    internships
  end

  def collect_results
    internships = Internship.all
    internships = filter_paid(internships)
    internships = filter_location(internships)
    internships = filter_orientation_id(internships)
    internships = filter_pl(internships)
    internships = sort_results(internships)
    internships
  end

  def set_programming_languages
    @programming_languages = ProgrammingLanguage.all.pluck(:name, :id)
  end

  def set_locations
    @locations = concat_countries_cities
  end
end

# frozen_string_literal: true

# Searches Helper
module SearchesHelper
  def filter_paid_true(internships)
    internships = internships.select do |i|
      # i.payment_state_id == 2 => "cash benefit"
      i.payment_state_id == 2 || i.salary.try(:positive?)
    end
    internships
  end

  def filter_paid_false(internships)
    internships = internships.select do |i|
      i.payment_state_id != 2 && (i.salary.nil? || i.salary <= 0)
    end
    internships
  end

  def filter_paid(internships)
    return internships if @search.paid.nil?
    return internships unless internships

    if @search.paid == true
      internships = filter_paid_true(internships)
    elsif @search.paid == false
      internships = filter_paid_false(internships)
    end
    internships
  end

  def filter_location(internships)
    loc = @search.location
    return internships unless loc
    return internships if loc.empty?

    return internships unless internships

    internships = internships.select do |i|
      address = i.company_address
      address.try(:city) == loc || address.try(:country_name) == loc
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

  def check_limit(internships)
    return internships unless internships

    internships = internships.select do |i|
      UserCanSeeInternship.internship_search(internship_id: i.id,
                                             user: current_user)
    end
    internships
  end

  def collect_results
    internships = Internship.where('start_date < CURRENT_DATE')
    internships = filter_paid(internships)
    internships = filter_location(internships)
    internships = filter_orientation_id(internships)
    internships = filter_pl(internships)
    internships = sort_results(internships)
    internships = check_limit(internships)
    internships
  end
end

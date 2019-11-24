# frozen_string_literal: true

# Helper Methods for the CompaniesController
module CompaniesHelper
  def case_for_count(count:, fuzzy_count:, limit:)
    c =  count.zero? && fuzzy_count.positive? ? fuzzy_count : count
    case c
    when 0
      'no_match'
    when 1..limit
      'suggestion'
    else
      'too_many'
    end
  end

  def search_name(name:)
    result_limit = 4
    results = Company.with_fuzzy_name(name)
    fuzzy_count = results.count
    results = Company.with_name(name) if fuzzy_count > result_limit
    [results, result_limit, fuzzy_count]
  end

  def company_suggestion(suggestion)
    results, result_limit, fuzzy_count = search_name(name: suggestion)
    search_case = case_for_count(count: results.count, fuzzy_count: fuzzy_count,
                                 limit: result_limit)
    return [search_case, nil] unless search_case == 'suggestion'

    results = results.select do |c|
      UserCanSeeCompany.company_search(company_id: c.id, user: current_user)
    end
    [search_case, results]
  end

  def redirect_successful_update
    if @current_user.student
      redirect_to edit_company_address_path(
        Internship.find(@internship_id).company_address
      ), notice: 'Company was successfully updated.'
    else
      redirect_to @company, notice: 'Company was successfully updated.'
    end
  end

  def redirect_successful_create
    redirect_to new_address_path(@company.id,
                                 internship_id: @internship_id),
                notice: 'Company was successfully created.'
  end
end

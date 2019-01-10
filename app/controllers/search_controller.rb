# frozen_string_literal: true

# Allow search on internships / filter by parameters
class SearchController < ApplicationController
  # include Response
  include ExceptionHandler
  skip_authorization_check


  def filter
    render json: {
      countries: CompanyAddress.countries,
      subject_areas: Orientation.names
      # # company_size: @company_size,
      # payment: @payment
    }
  end
end

# frozen_string_literal: true

# StartPage is the landing page for the app
class StartpageController < ApplicationController
  include MapHelper
  skip_before_action :authenticate_user!
  skip_authorization_check only: [:new]

  def new
    redirect_to overview_index_url if user_signed_in?
    @map_view = true
    @company_location_json = company_locations_json
  end
end

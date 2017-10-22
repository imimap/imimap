# frozen_string_literal: true

# StartPage is the landing page for the app
class StartpageController < ApplicationController
  include MapHelper
  skip_before_action :authenticate_user!
  layout 'startpage'

  def new
    redirect_to overview_index_url if user_signed_in?
    @company_location_json = company_locations_json
  end
end

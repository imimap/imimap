# frozen_string_literal: true

# Start Page with Map overview
class OverviewController < ApplicationController
  skip_before_action :authenticate_user!
  include MapHelper
  def index
    @map_view = true
    @company_location_json = company_locations_json
  end

  def debug
  end
end

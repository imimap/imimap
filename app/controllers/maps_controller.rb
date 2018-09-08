# frozen_string_literal: true

# Controller for all map views
class MapsController < ApplicationController
  skip_authorization_check only: [:start_page]
  include MapHelper
  def start_page
    @map_view = true
    @company_location_json = company_locations_json
  end

  def debug; end
end

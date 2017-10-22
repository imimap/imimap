class OverviewController < ApplicationController
  before_filter :get_programming_languages, :get_orientations
  include MapHelper

  def index
    @company_location_json = company_locations_json
    respond_to do |format|
      format.html
      format.js
    end
  end
end

# frozen_string_literal: true

# TBD Search - Favourites are switched off and should be
# restaurated with the search
class FavoriteCompareController < ApplicationController
  def index
    @internships = []
    # @internships = if params[:favorite_ids]
    #                  Internship.find(params[:favorite_ids])
    #                else
    #                  []
    #                end

    respond_to do |format|
      format.js { render layout: false }
    end
  end
end

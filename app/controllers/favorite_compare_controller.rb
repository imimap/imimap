# frozen_string_literal: true

class FavoriteCompareController < ApplicationController
  def index
    @internships = if params[:favorite_ids]
                     Internship.find(params[:favorite_ids])
                   else
                     []
                   end

    respond_to do |format|
      format.js { render layout: false }
    end
  end
end

class FavoriteCompareController < ApplicationController
  skip_before_action :authorize_user!
  def index
    if params[:favorite_ids]
    	@internships = Internship.find(params[:favorite_ids])
    else
    	@internships = []
    end

    respond_to do |format|
      format.js { render :layout=>false }
    end

  end


end

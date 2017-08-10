class InternshipStatusController < ApplicationController
  respond_to :html, :json

  before_filter :authorize



  def index

    @internship = Internship.where(user_id: current_user).last

  end


end

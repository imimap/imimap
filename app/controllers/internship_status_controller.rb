class InternshipStatusController < ApplicationController

  before_filter :authorize



  def index



    #@internship = Internship.where(user_id: current_user.id).last

    @internship = Internship.where(user_id: current_user).last


  end


end

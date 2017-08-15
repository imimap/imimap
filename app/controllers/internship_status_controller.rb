class InternshipStatusController < ApplicationController
  respond_to :html, :json
  before_filter :authorize



  def index

    # @internships = Internship.where(report_state_id: ReportState.second, semester_id: Semester.first)

    #@internship = Internship.where(user_id: current_user.id).last

    @internship = Internship.where(user_id: current_user).last





  end


end

class ReadListController < ApplicationController
  #check the user if current user nil or not
  before_filter :authorize


  # create a new assigned report/unread list and save it
  def create

    @read_list = AssignedReport.new

    @read_list.internship_id = params[:internship_id]
    @read_list.user_id = params[:user_id]
    @read_list.save


    @current_user = @assigned_report.user
    @internship = @assigned_report.internship

    respond_to do |format|
      format.js { render :layout=>false, :locals => { :current_user  => @current_user, :internship => @internship, :read_list => @read_list} }


    end
  end

end

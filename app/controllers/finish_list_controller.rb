class FinishListController < ApplicationController

  #check the user if current user nil or not
  respond_to :html, :json


  # create a new assigned report/unread list and save it
  def create

    @finish_list = FinishList.new

    @finish_list.internship_id = params[:internship_id]
    @finish_list.user_id = params[:user_id]
    @finish_list.save

    @current_user = @finish_list.user
    @internship = @finish_list.internship

    flash[:notice] = "Post successfully created"

    respond_to do |format|

      format.html { redirect_to(finish_list_index_path) }
      format.js { render :layout=>false, :locals => { :current_user  => @current_user, :internship => @internship, :finish_list => @finish_list} }


    end
  end

  def destroy
    @internships = FinishList.find(params[:finish_list_ids])
    @internships.map(&:destroy)

    respond_to do |format|
      format.html { redirect_to finish_list_index_path }
      format.js { render :layout=>false,:locals => { :current_user  => @current_user, :internship => @internship, :finish_list => @finish_list} }

    end
  end


  def index

    @finish_lists = current_user.finish_lists

  end
end

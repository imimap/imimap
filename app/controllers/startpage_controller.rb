class StartpageController < ApplicationController
  layout 'startpage'

  def new
    if current_user
      redirect_to overview_index_url
    end

    @company_location_json = Company.pluck(:name, :latitude, :longitude).to_json.html_safe
    @internships = Internship.includes(:company, :semester, :orientation, :programming_languages).where(completed: true).order('created_at DESC')
  end


  def create
    user = User.find_by_email(params[:email])
    #
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to overview_index_url, notice: "Logged in!"
      #if params[:remember_me]
      #  cookies.permanent[:auth_token] = user.auth_token
      #else
      #  cookies[:auth_token] = user.auth_token
      #end
      #redirect_to overview_index_url, :notice => "Logged in!"

    else
      #flash.now.alert = "Email or password is invalid"
      flash[:alert] = t("msg.invalid")

      redirect_to :back
    end
  end

  def destroy
    startpage[:user_id] = nil
    #cookies.delete(:auth_token)
    redirect_to root_url, :alert =>  t("msg.logout")
  end

 end

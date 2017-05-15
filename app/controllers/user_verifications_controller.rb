class UserVerificationsController < ApplicationController

  def new
    respond_to do |format|
      format.js { render :layout=>false }
    end
  end

  def create
    authorized = LdapAuthentication.authorized?(params[:user_name], params[:password])
    if authorized
      matrikel = params[:user_name].split("s0")[1]
      matrikel = matrikel.nil? ? "n/a" : matrikel
      session[:enrolment_number] = matrikel
      redirect_to new_user_path
    else
      flash[:error] =  I18n.t('ldap.authorization_failed')
      redirect_to root_url
    end
  end
end

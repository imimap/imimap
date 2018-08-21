# frozen_string_literal: true

#
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :authenticate_user!

  def authenticate_active_admin_user!
    result = authenticate_user!
    throw(:warden) unless result.admin?
  end

  def authorize_role_examination_office
  end

  def authorize_role_professor
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }
  end

    # we use devise logic instead
    # def current_user
    #   @current_user = User.find(session[:user_id]) if session[:user_id]
    #   #@current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
    #   rescue ActiveRecord::RecordNotFound
    #     session.destroy
    #     nil
    # end

    # helper_method :current_user

    def get_programming_languages
      @programming_languages ||= ProgrammingLanguage.order(:name).map do |p|
        [p.name, p.id]
      end
    end

    helper_method :get_programming_languages

    def get_orientations
      @orientations ||= Orientation.order(:name).map do |o|
        [o.name, o.id]
      end
    end

    helper_method :get_orientations

    def get_semesters
      @semesters ||= Semester.order(:id).map do |s|
        [s.name, s.id]
      end
    end

    helper_method :get_semesters



    def get_notification_size
      Notification.where(:user_id => current_user.try(:id)).size
    end

    helper_method :get_notification_size

    # see https://github.com/plataformatec/devise/wiki/How-To:-redirect-to-a-specific-page-on-successful-sign-in
    # https://github.com/plataformatec/devise/wiki/How-To:-redirect-to-a-specific-page-on-successful-sign_in,-sign_out,-and-or-sign_up
    def after_sign_in_path_for(resource)
      overview_index_path
    end

end

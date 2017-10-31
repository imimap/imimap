# frozen_string_literal: true

#
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :set_locale
  before_action :authenticate_user!

  def authenticate_active_admin_user!
    authenticate_user!
  end

  def authorize_role_pruefungsverwaltung
  end
  def authorize_role(role)
    # :pruefungsverwaltung
    true
  end

  def auth_Prof
    if !(current_user.email.match(/^(s0538111@htw-berlin.de|s0538144@htw-berlin.de)$/))
    redirect_to overview_index_path
    end
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

end

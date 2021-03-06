# frozen_string_literal: true

# Superclass of all Controllers.
class ApplicationController < ActionController::Base
  # protect_from_forgery
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :authenticate_user!
  check_authorization unless: :devise_or_active_admin_controller?

  def devise_or_active_admin_controller?
    devise_controller? || active_admin_controller?
  end

  def active_admin_controller?
    self.class.name.split('::').first == 'Admin'
  end

  def authenticate_active_admin_user!
    user = authenticate_user!
    throw(:warden) unless user.admin?
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    # use this to always have a flash notice for testing
    # flash[:notice] = 'The flash notice'
  end

  def default_url_options(_options = {})
    { locale: I18n.locale }
  end

  def programming_languages
    @programming_languages ||= ProgrammingLanguage.order(:name).map do |p|
      [p.name, p.id]
    end
  end

  def payment_states
    @payment_states ||= PaymentState.order(:name).map do |ps|
      [ps.name, ps.id]
    end
  end

  helper_method :get_programming_languages

  def orientations
    @orientations ||= Orientation.order(:name).map do |o|
      [o.name, o.id]
    end
  end

  helper_method :orientations

  # TBD ST: only used in internships#new
  def semesters
    @semesters ||= Semester.order(:id).map do |s|
      [s.name, s.id]
    end
  end

  helper_method :semesters

  def notification_size
    Notification.where(user_id: current_user.try(:id)).size
  end

  helper_method :get_notification_size

  # see https://github.com/plataformatec/devise/wiki/
  # How-To:-redirect-to-a-specific-page-on-successful-sign-in
  # https://github.com/plataformatec/devise/wiki/
  # How-To:-redirect-to-a-specific-page-on-successful-sign_in,
  # -sign_out,-and-or-sign_up
  def after_sign_in_path_for(_resource)
    root_path
  end
end

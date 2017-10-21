# frozen_string_literal: true

# For Notifications
class InternshipNotificationHandler
  attr_reader :internship, :student, :user

  def initialize(options)
    @internship = options[:internship]
    @student = internship.student
    @user = student.user
  end

  def notify
    send_notification
    send_email
  end

  private

  def send_notification
    helpers = Rails.application.routes.url_helpers
    link = helpers.edit_internship_url(internship, locale: I18n.locale)
    user.notifications.create(text: 'noti.report',
                              link: link)
  end

  def send_email
    return unless user&.mailnotif
    InternshipMailer.internship_ready(internship, user).deliver_now
  end
end

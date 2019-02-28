# frozen_string_literal: true

# TBD refactor observers
# https://github.com/rails/rails-observers
class AnswerObserver < ActiveRecord::Observer
  def after_save(answer)
    noti = Notification.new
    noti.user_id = answer.user_comment.user.id
    noti.text = 'noti.answer'
    noti.link = format("/%<locale>s/internships/%<internship_id>s",
      locale: I18n.locale,
      internship_id: answer.user_comment.internship.id)
    noti.read = false
    noti.save
  end
end

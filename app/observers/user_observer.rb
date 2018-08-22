# frozen_string_literal: true

class UserObserver < ActiveRecord::Observer
  def after_create(model)
    return unless model.student&.internships
    model.student.internships.each do |internship|
      next unless internship.editable?
      InternshipNotificationHandler.new(internship: internship).notify
    end
  end
end

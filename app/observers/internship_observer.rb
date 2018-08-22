# frozen_string_literal: true

class InternshipObserver < ActiveRecord::Observer
  def after_update(model)
    if model.saved_change_to_attribute(:report_state) && model.editable?
      InternshipNotificationHandler.new(internship: model).notify
    end
  end
end

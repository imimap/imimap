# frozen_string_literal: true

class InternshipObserver < ActiveRecord::Observer
  # TBD: wofuer ist das?
  def after_update(model)
    condition = model.saved_change_to_attribute(:report_state) && model.editable?
    InternshipNotificationHandler.new(internship: model).notify if condition
  end
end

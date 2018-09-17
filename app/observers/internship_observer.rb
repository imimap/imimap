# frozen_string_literal: true

# TBD refactor observers
# https://github.com/rails/rails-observers
class InternshipObserver < ActiveRecord::Observer
  def after_update(model)
    condition = model.saved_change_to_attribute(:report_state) && model.editable?
    InternshipNotificationHandler.new(internship: model).notify if condition
  end
end

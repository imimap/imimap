# frozen_string_literal: true

def active_admin_date(date)
  I18n.localize(date, format: :long)
end

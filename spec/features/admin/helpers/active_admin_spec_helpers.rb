# frozen_string_literal: true

RSpec.configure do |config|
  config.include CompanyAddressesHelper
  config.include StudentsHelper
end
def active_admin_date(date)
  I18n.localize(date, format: :long)
end

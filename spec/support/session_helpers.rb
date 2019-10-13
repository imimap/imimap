# frozen_string_literal: true

# adapted from
# https://robots.thoughtbot.com/rspec-integration-tests-with-capybara
module Features
  # SessionHelpers create a session via the interface
  module SessionHelpers
    def login_via_interface_with(user)
      visit root_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_on t('.devise.sessions.submit')
    end
  end
end

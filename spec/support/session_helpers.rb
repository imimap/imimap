# adapted from https://robots.thoughtbot.com/rspec-integration-tests-with-capybara
module Features
  module SessionHelpers
    def login_with(user)
      visit root_path
      fill_in "email",  :with => user.email
      fill_in "password",  :with => user.password
      page.find('.signin-icon').click
    end
  end
end

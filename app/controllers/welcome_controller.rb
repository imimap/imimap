class WelcomeController < ApplicationController
  skip_authorization_check
  # renders the help site
  def help; end
end

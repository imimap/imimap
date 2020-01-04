# frozen_string_literal: true

# Controller with welcoming name for hosting the help page and possibly
# other static pages.
class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:login]
  skip_authorization_check
  # renders the help site
  def help
    # tbd: somehow @current_user is available in all other controllers.
    @current_user = current_user
  end

  def login; end
end

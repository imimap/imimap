# frozen_string_literal: true

# Controller with welcoming name for hosting the help page and possibly
# other static pages.
class WelcomeController < ApplicationController
  skip_authorization_check
  # renders the help site
  def help; end
end

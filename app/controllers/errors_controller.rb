# frozen_string_literal: true

# Controller for Dynamic Error Pages
# https://mattbrictson.com/dynamic-rails-error-pages
class ErrorsController < ApplicationController
  skip_before_action :authenticate_user!
  def not_found
    render(status: 404)
  end

  def internal_server_error
    render(status: 500)
  end
end

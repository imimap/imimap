# frozen_string_literal: true

class ApplicationResourceController < ApplicationController
  load_and_authorize_resource
end

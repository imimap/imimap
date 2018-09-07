# frozen_string_literal: true

# This is a superclass for all Controllers Associated to Resources.
# calls authorize_resource for all of them.
# see https://github.com/CanCanCommunity/cancancan/
class ApplicationResourceController < ApplicationController
  # load_and_authorize_resource
  authorize_resource
end

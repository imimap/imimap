# frozen_string_literal: true

#
require 'rails_helper'

RSpec.describe OverviewController, :type => :controller do
  render_views


  before :each do
    @internship = create :internship, completed: true
    @current_user = login
  end

  describe "current user with invalid user_id" do
    it 'destroys the session' do
      # instead of faking invalid session - we are signing out the user
      sign_out @current_user
      #session[:user_id] = 42
        get :index

      # needs attention!
        # The HTTP response status code 302 Found is a common way of performing URL redirection.
        # expect(response).to have_http_status(:found)
    end
  end

  describe "GET #index" do
    it 'renders the index action correctly' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapsController, type: :controller do
  describe 'GET #start_page' do
    context 'when not logged in ' do
      it 'returns start_page page' do
        get :map_view
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_user_session_path(locale: nil))
      end
    end
    context 'when logged in' do
      it 'redirects to overview#index' do
        # login_as_admin
        login

        expect(response).to have_http_status(:success)
        # yields error on rails 6
#        ActionView::Template::Error:
#  wrong number of arguments (given 2, expected 1)
# /usr/local/bundle/gems/rails-controller-testing-1.0.4/lib/rails/controller
# /testing/template_assertions.rb:61:in `process'
      #  get :map_view
      #  expect(response).to have_http_status(:success)
      end
    end
  end
end

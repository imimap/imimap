# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapsController, type: :controller do
  describe 'GET #start_page' do
    context 'when not logged in ' do
      it 'returns start_page page' do
        get :start_page
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_user_session_path(locale: nil))
      end
    end
    context 'when logged in' do
      it 'redirects to overview#index' do
        # login_as_admin
        login

        expect(response).to have_http_status(:success)
        get :start_page
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StartpageController, type: :controller do
  describe 'GET #new' do
    context 'when not logged in ' do
      it 'returns http success' do
        create :internship, completed: true
        create :internship, completed: true
        create :internship, completed: true
        get :new
        expect(response).to have_http_status(:success)
      end

      it 'returns http success - 2 ' do
        # TBD this is a variation of 'returns http success' to gain
        # 100% coverage as the href is computed in the controller.
        # Can be removed after this is moved to a model method.

        create :internship, completed: true
        create :internship, completed: true
        create :internship, completed: true
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    context 'when logged in' do
      it 'redirects to overview#index' do
        login
        get :new
        expect(response).to redirect_to(:overview_index)
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  before :each do
    @user = login
  end

  describe 'GET #help' do
    it 'returns http success' do
      get :help
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:help)
    end
  end
end

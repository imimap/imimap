# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

  before :each do
    @current_user = login_as_admin
  end

  describe 'GET #show' do
    it 'renders the show template' do
      get :show, params: { id: @current_user }
      expect(response).to render_template :show
    end

    it 'assigns @user' do
      get :show, params: { id: @current_user }
      expect(assigns(:user)).to eq @current_user
    end

    it 'assigns @internships' do
      get :show, params: { id: @current_user }
      expect(assigns(:internships)).to eq []
    end
  end
end

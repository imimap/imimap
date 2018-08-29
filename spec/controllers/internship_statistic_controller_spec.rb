# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OverviewController, type: :controller do
  render_views

  before :each do
    @current_user = login_as_admin
  end

  describe 'template is shown' do
    it 'shows the index view' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #index' do
    it 'shows index view with the right id' do
      get :index, params: { id: @semester_id }
      expect(assigns(:semester_id)).to eq(@semester_id)
    end
  end
end

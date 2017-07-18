require 'rails_helper'

RSpec.describe OverviewController, :type => :controller do
  render_views


  before :each do
    @current_user = login
  end

  describe "statistic is shown" do
    it 'shows the index view' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe "GET #index" do
    it 'renders the show action correctly' do
      get :index
      expect(assigns(:semester_id)).to eq(@semester_id)
    end
end
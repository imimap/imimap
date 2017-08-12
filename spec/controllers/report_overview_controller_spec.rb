require 'rails_helper'

RSpec.describe ReportOverviewController, type: :controller do
  render_views

  before :each do
    @internship = create :internship
    @current_user = login
  end

  describe "GET #index" do


    it 'renders the index action' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns @internships' do
      get :index
      expect(assigns(:internships)).to eq([@internship])
    end



  end

end

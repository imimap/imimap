require 'rails_helper'

RSpec.describe ReportOverviewController, type: :controller do

  describe "GET #index" do


    it 'renders the index action correctly' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns @internships' do
      create :internship, completed: false

      get :index
      expect(assigns(:internships)).to eq([@internship])
    end

    it 'assigns @companies' do
      get :index
      expect(assigns(:companies)).to eq([@internship].map(&:company))
    end


    it 'assigns @semesters' do
      get :index
      expect(assigns(:semesters)).to eq([@internship].map(&:semester))
    end

  end

end

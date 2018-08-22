# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReportOverviewController, type: :controller do
  render_views

  before :each do
    @internship = create :internship
    @current_user = login
    @current_user.email << 's0538144@htw-berlin.de'
  end

  describe 'GET #index' do
    it 'renders the index action' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns @internships' do
      get :index
      expect(assigns(:internships)).to eq([@internship])
    end

    it 'assigns @current_user' do
      get :index
      expect(assigns(:current_user)).to eq @current_user
    end

    it 'assigns @semesters' do
      get :index
      expect(assigns(:semesters)).to eq([[@internship.semester.name, @internship.semester.id]])
    end
  end
end

require 'rails_helper'

RSpec.describe OverviewController, :type => :controller do
  render_views


  before :each do
    @current_user = login
  end

  describe "template is shown" do
    it 'shows the index view' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe "GET #index" do
    it 'shows index view with the right id' do
      get :index, id: @semester_id
      @semester_id = Semester.first.id
      expect(assigns(:semester_id)).to eq(@semester_id)
    end
  end

    describe "GET #index" do
    it 'shows index view by default with last semester id' do
      get :index, id: nil
      semester_id = Semester.last.id
      expect(assigns(:semester_id)).to eq(@semester_id)
    end
  end
end
require 'rails_helper'

RSpec.describe ReadListController, type: :controller do
  render_views

  before :each do
    @current_user = login
    @internship = create :internship
    @read_list = create :read_list, internship: @internship
    @current_user.read_lists << @read_list
  end

  describe "GET #index" do
    it 'assigns @read_lists' do
      get :index
      expect(assigns(:read_lists)).to eq([@current_user.read_lists.first])
    end

    it 'renders index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end





end

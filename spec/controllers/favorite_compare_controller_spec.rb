# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FavoriteCompareController, type: :controller do
  render_views

  before :each do
    @current_user = login_as_admin
  end

  describe 'GET #index' do
    it 'assigns @internships' do
      @internship = create :internship

      get :index, format: :js, xhr: true
      expect(assigns(:internships)).to eq([])
      # TBD Comments
      #    get :index, format: :js, xhr: true, params:
      #    { favorite_ids: [@internship.id] }
      #    expect(assigns(:internships)).to eq([@internship])
    end

    it 'renders the index template ' do
      get :index, format: :js, xhr: true
      expect(response).to render_template(:index)
    end
  end
end

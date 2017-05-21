require 'rails_helper'

RSpec.describe FavoriteCompareController, :type => :controller do
  render_views

  describe "GET #index" do
    it 'assigns @internships' do
      @internship = create :internship

      xhr :get, :index, format: :js
      expect(assigns(:internships)).to eq([])

      xhr :get, :index, format: :js, favorite_ids: [@internship.id]
      expect(assigns(:internships)).to eq([@internship])
    end

    it 'renders the index template ' do
      xhr :get, :index, format: :js
      expect(response).to render_template(:index)
    end
  end

end

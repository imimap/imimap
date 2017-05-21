require 'rails_helper'

RSpec.describe CompaniesController, :type => :controller do
  render_views
  describe "GET #index" do
  before :each do
    @admin_user = FactoryGirl.build(:admin_user)
    sign_in @admin_user
  end

    it 'works' do
      pending "sign in to devise doesn't work"
      #get :index
      expect(controller.signed_in?).to be_truthy
      expect(controller.current_admin_user).to eq :x
      expect(response).to have_http_status(:success)
      expect(response).to render_template :index
    end
  end
end

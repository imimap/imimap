require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  describe "GET #new" do
    context 'when not logged in ' do
      it "returns http success" do
        create :internship, completed: true
        company = create :company, website: "foo.bar"
        create :internship, completed: true, company: company
        create :internship, completed: true, company: company
        get :new
        expect(response).to have_http_status(:success)
      end

      it "returns http success - 2 " do
        # TBD this is a variation of 'returns http success' to gain 100% coverage
        # as the href is computed in the controller. Can be removed after this is moved to a model method.

        create :internship, completed: true
        company = create :company, website: "http://foo.bar"
        create :internship, completed: true, company: company
        create :internship, completed: true, company: company
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    context 'when logged in' do
      it 'redirects to overview#index' do
        login
        get :new
        expect(response).to redirect_to(:overview_index)
      end
    end
  end

  describe "POST #create" do
    context 'without successful authentication' do
      it "redirects to :back" do
        request.env["HTTP_REFERER"] = '/'
        post :create
        expect(response).to redirect_to("/")
      end
    end

    context 'with successful authentication' do
      it "redirects to overview#index" do
        user = create :user, password: "foofoofoo", password_confirmation: "foofoofoo", email: "foo@bar.com"
        post :create, email: user.email, password: "foofoofoo"
        expect(response).to redirect_to(:overview_index)
      end
    end
  end

  describe "GET #destroy" do
    it "redirects to root_url" do
      get :destroy
      expect(response).to redirect_to(:root)
    end
  end

end

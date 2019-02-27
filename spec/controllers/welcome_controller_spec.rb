require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

  describe "GET #help" do
    it "returns http success" do
      get :help
      expect(response).to have_http_status(:success)
    end
  end

end

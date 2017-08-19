require 'rails_helper'

RSpec.describe "Reads", type: :request do
  describe "GET /reads" do
    it "works! (now write some real specs)" do
      get reads_path
      expect(response).to have_http_status(200)
    end
  end
end

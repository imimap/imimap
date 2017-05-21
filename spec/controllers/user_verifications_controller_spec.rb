require 'rails_helper'

RSpec.describe UserVerificationsController, :type => :controller do
  render_views

  describe "GET #new" do
    it 'renders the new template' do
      xhr :get, :new, format: :js
      expect(response).to render_template :new
    end
  end
end

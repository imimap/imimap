require 'rails_helper'

RSpec.describe UserVerificationsController, :type => :controller do
  render_views

  describe "GET #new" do
    it 'renders the new template' do
      xhr :get, :new, format: :js
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    it 'renders the new template' do
      xhr :post, :create, user_name: 's0123456@htw-berlin.de', password: 'geheim123',  format: :js
      expect(response).to redirect_to(:new_user)
    end
    context "with failing ldap authorization" do
      before :each do
        LdapAuthentication.configure(mode: :test_fail)
      end
      after :each do
        LdapAuthentication.configure(mode: :test)
      end
      it 'redirects to root ' do
        xhr :post, :create, user_name: 's0123456@htw-berlin.de', password: 'geheim123',  format: :js
        expect(response).to redirect_to(:root)
      end
    end

  end

end

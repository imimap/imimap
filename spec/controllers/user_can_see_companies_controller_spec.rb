# frozen_string_literal: true

require 'rails_helper'

# Generated spec
RSpec.describe UserCanSeeCompaniesController, type: :controller do
  render_views

  before :each do
    @current_user = login_as_admin
    @company = create(:company)
  end
  context 'generated specs' do
    # This should return the minimal set of attributes required to create a
    # valid
    # UserCanSeeCompany. As you add validations to UserCanSeeCompany, be sure to
    # adjust the attributes here as well.
    let(:valid_attributes) do
      { user_id: @current_user.id,
        company_id: @company.id,
        created_by: 'company_suggest' }
    end

    let(:invalid_attributes) do
      { user_id: @current_user.id, created_by: 'company_suggest' }
    end

    # This should return the minimal set of values that should be in the session
    # in order to pass any filters (e.g. authentication) defined in
    # UserCanSeeCompaniesController. Be sure to keep this updated too.
    let(:valid_session) { {} }

    describe 'GET #index' do
      it 'returns a success response' do
        UserCanSeeCompany.create! valid_attributes
        get :index, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe 'GET #show' do
      it 'returns a success response' do
        user_can_see_company = UserCanSeeCompany.create! valid_attributes
        get :show, params: { id: user_can_see_company.to_param },
                   session: valid_session
        expect(response).to be_successful
      end
    end

    describe 'GET #new' do
      it 'returns a success response' do
        get :new, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe 'GET #edit' do
      it 'returns a success response' do
        user_can_see_company = UserCanSeeCompany.create! valid_attributes
        get :edit, params: { id: user_can_see_company.to_param },
                   session: valid_session
        expect(response).to be_successful
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'creates a new UserCanSeeCompany' do
          expect do
            post :create, params: { user_can_see_company: valid_attributes },
                          session: valid_session
          end.to change(UserCanSeeCompany, :count).by(1)
        end

        it 'redirects to the created user_can_see_company' do
          post :create, params: { user_can_see_company: valid_attributes },
                        session: valid_session
          expect(response).to redirect_to(UserCanSeeCompany.last)
        end
      end

      context 'with invalid params' do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: { user_can_see_company: invalid_attributes },
                        session: valid_session
          expect(response).to be_successful
        end
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        let(:new_attributes) do
          { created_by: 'unknown' }
        end

        it 'updates the requested user_can_see_company' do
          user_can_see_company = UserCanSeeCompany.create! valid_attributes
          put :update, params: {
            id: user_can_see_company.to_param,
            user_can_see_company: new_attributes
          },
                       session: valid_session
          user_can_see_company.reload
          expect(user_can_see_company.created_by).to eq 'unknown'
        end

        it 'redirects to the user_can_see_company' do
          user_can_see_company = UserCanSeeCompany.create! valid_attributes
          put :update, params: { id: user_can_see_company.to_param,
                                 user_can_see_company: valid_attributes },
                       session: valid_session
          expect(response).to redirect_to(user_can_see_company)
        end
      end

      # context 'with invalid params' do
      #   it "returns a success response (i.e. to display the 'edit' template)" do
      #     user_can_see_company = UserCanSeeCompany.create! valid_attributes
      #     put :update, params: { id: user_can_see_company.to_param,
      #                            user_can_see_company: invalid_attributes },
      #                  session: valid_session
      #     expect(response).to redirect_to(edit_user_can_see_company_path)
      #     expect(response).to be_successful
      #   end
      # end
    end

    describe 'DELETE #destroy' do
      it 'destroys the requested user_can_see_company' do
        user_can_see_company = UserCanSeeCompany.create! valid_attributes
        expect do
          delete :destroy, params: { id: user_can_see_company.to_param },
                           session: valid_session
        end.to change(UserCanSeeCompany, :count).by(-1)
      end

      it 'redirects to the user_can_see_companies list' do
        user_can_see_company = UserCanSeeCompany.create! valid_attributes
        delete :destroy, params: { id: user_can_see_company.to_param },
                         session: valid_session
        expect(response).to redirect_to(user_can_see_companies_url)
      end
    end
  end
end

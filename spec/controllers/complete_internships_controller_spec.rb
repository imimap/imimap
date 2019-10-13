# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CompleteInternshipsController, type: :controller do
  render_views

  before :each do
    @current_user = login_as_admin
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CompleteInternshipsController. Be sure to keep this updated too.
  let(:valid_session) { {} }
  let(:valid_attributes) do
    build(:complete_internship)
      .attributes
      .merge(student_id: create(:student).id)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      create(:complete_internship)
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      complete_internship = create(:complete_internship)
      get :show, params: { id: complete_internship.to_param },
                 session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new,
          params: { complete_internship: valid_attributes },
          session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      complete_internship = create(:complete_internship)
      get :edit,
          params: { id: complete_internship.to_param },
          session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new CompleteInternship' do
        expect do
          post :create,
               params: { complete_internship:
                 valid_attributes },
               session: valid_session
        end.to change(CompleteInternship, :count).by(1)
      end

      it 'redirects to the created complete_internship' do
        post :create,
             params: { complete_internship:
               valid_attributes },
             session: valid_session
        expect(response).to redirect_to(CompleteInternship.last)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        h = valid_attributes
        h['semester_of_study'] = 9
        h
      end

      it 'updates the requested complete_internship' do
        complete_internship = CompleteInternship.create! valid_attributes
        put :update,
            params: { id: complete_internship.to_param,
                      complete_internship: new_attributes },
            session: valid_session
        complete_internship.reload
        expect(complete_internship.semester_of_study).to eq 9
      end

      it 'redirects to the complete_internship' do
        complete_internship = CompleteInternship.create! valid_attributes
        put :update,
            params: { id: complete_internship.to_param,
                      complete_internship: valid_attributes },
            session: valid_session
        expect(response).to redirect_to(complete_internship)
      end
    end

    #  context 'with invalid params' do
    #    it "returns a success response (i.e. to display the 'edit' template)"
    # do
    #      complete_internship = CompleteInternship.create! valid_attributes
    #      put :update,
    #          params: { id: complete_internship.to_param,
    #                    complete_internship: invalid_attributes },
    #          session: valid_session
    #      expect(response).to be_successful
    #    end
    #  end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested complete_internship' do
      complete_internship = CompleteInternship.create! valid_attributes
      expect do
        delete :destroy,
               params: { id: complete_internship.to_param },
               session: valid_session
      end.to change(CompleteInternship, :count).by(-1)
    end

    it 'redirects to the complete_internships list' do
      complete_internship = CompleteInternship.create! valid_attributes
      delete :destroy,
             params: { id: complete_internship.to_param },
             session: valid_session
      expect(response).to redirect_to(complete_internships_url)
    end
  end
end

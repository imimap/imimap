# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

  describe 'GET #show' do
    context 'as admin' do
      before :each do
        @current_user = login_as_admin
      end

      it 'renders the show template' do
        get :show, params: { id: @current_user }
        expect(response).to render_template :show
      end

      it 'assigns @user' do
        get :show, params: { id: @current_user }
        expect(assigns(:user)).to eq @current_user
      end

      it 'assigns @internships' do
        get :show, params: { id: @current_user }
        expect(assigns(:internships)).to eq []
      end
    end

    context 'as student' do
      before :each do
        @current_user = login_with(user_factory: :student_admin)
      end

      it 'assigns @internships of student' do
        get :show, params: { id: @current_user }
        expect(assigns(:internships)).to eq(
          @current_user.student.internships
        )
      end

      it 'assigns @user_first_name of student' do
        get :show, params: { id: @current_user }
        expect(assigns(:user_first_name)).to eq(
          @current_user.student.first_name
        )
      end

      it 'assigns @user_last_name of student' do
        get :show, params: { id: @current_user }
        expect(assigns(:user_last_name)).to eq(
          @current_user.student.last_name
        )
      end
    end
  end
end

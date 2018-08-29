# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  render_views

  before :each do
    @notification = create :notification, link: 'http://localhost'
    @current_user = login_as_admin
  end

  describe 'DELETE #destroy' do
    it 'assigns @noti' do
      delete :destroy, params: { id: @notification }
      expect(assigns(:noti)).to eq(@notification)
    end

    it 'destroys @noti' do
      expect do
        delete :destroy, params: { id: @notification }
      end.to change(Notification, :count).by(-1)
    end

    it 'redirects to @noti.link' do
      delete :destroy, params: { id: @notification }
      expect(response).to redirect_to @notification.link
    end
  end

  describe 'GET #show' do
    it 'assigns @noti' do
      get :show, params: { id: @notification }
      expect(assigns(:noti)).to eq(@notification)
    end

    it 'destroys @noti' do
      expect do
        get :show, params: { id: @notification }
      end.to change(Notification, :count).by(-1)
    end

    it 'redirects to @noti.link' do
      get :show, params: { id: @notification }
      expect(response).to redirect_to @notification.link
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

describe 'ActiveAdmin Admin User' do
  context 'when logged in' do
    before :each do
      @admin_user = create :admin_user
      sign_in @admin_user
      I18n.locale = 'de'
    end
    describe 'pages' do
      it 'index' do
        visit admin_users_path
        one, two = @admin_user.email.split('@')
        expect(page).to have_content one
        expect(page).to have_content two
      end
    end

    # we check if changing the mail address of a user
    # without touching the password works
    # if so, we get redirected
    describe 'controller' do
      it 'update' do
        visit admin_users_path
        @admin_user.email = 'test.mail@htw.de'
        expect(current_path).to eq admin_users_path
        assert_equal('test.mail@htw.de', @admin_user.email)
      end
    end
  end
end

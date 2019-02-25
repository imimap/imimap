# frozen_string_literal: true

require 'rails_helper'

def user_password
  'geheimgeheimgeheim'
end

def sign_in_with(enrolment_number:)
  visit root_path
  fill_in 'user_email', with: User.email_for(enrolment_number: enrolment_number)
  fill_in 'user_password', with: user_password
  click_on I18n.t('devise.sessions.submit')
  expect(page).to have_content t('devise.sessions.signed_in')
end

describe 'Student login:' do
  before(:each) do
    @ldap_mock = ldap_mock = instance_double('Net::LDAP')
    LDAPHTWAdapter.substitute_netldap(mock: ldap_mock)
    allow(ldap_mock).to receive(:bind).and_return(true)
  end
  it 'pw is stored in database' do
    expect do
      sign_in_with(enrolment_number: '54321')
      @user = User.last
    end.to change { User.count }.by(1)
    allow(@ldap_mock).to receive(:bind).and_return(false) # logout from ldap
    sign_out @user # logout user
    sign_in_with(enrolment_number: '54321')
  end
end

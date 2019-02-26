# frozen_string_literal: true

require 'rails_helper'

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
  it 'pw was changed and gets updated in db' do
    expect do
      sign_in_with(enrolment_number: '54321')
      @user = User.last
      @old_pw = @user.encrypted_password
      sign_out @user
    end.to change { User.count }.by(1)
    sign_in_with(enrolment_number: '54321', password: 'neuneuneu')
    !assert_equal(@user.encrypted_password, @old_pw)
  end
end

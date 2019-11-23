# frozen_string_literal: true

# require 'ldap/ldaphtw_adapter'
require 'rails_helper'

describe LDAPHTWAdapter, type: :feature do
  before(:each) do
    LDAPHTWAdapter.substitute_netldap(mock: nil)
  end
  context 'with real configuration' do
    it 'does not authenticate' do
      ldap_adapter = LDAPHTWAdapter.new(email: 'email@htw-berlin.de')
      auth_successful = ldap_adapter
                        .create(ldap_password: 'egal')
                        .authenticate
      expect(auth_successful).to be false
    end
  end
  context 'with mock configuration' do
    before(:each) do
      allow_ldap_login(success: true)
    end
    it 'authenticates' do
      ldap_adapter = LDAPHTWAdapter.new(email: 'email@htw-berlin.de')
      auth_successful = ldap_adapter
                        .create(ldap_password: 'egal')
                        .authenticate
      expect(auth_successful).to be true
    end
  end
  context 'with always_return_true' do
    before(:each) do
      @store = ENV['LDAP']
      ENV['LDAP'] = 'ALWAYS_RETURN_TRUE'
    end
    after(:each) do
      ENV['LDAP'] = @store
    end
    it 'authenticates' do
      ldap_adapter = LDAPHTWAdapter.new(email: 'email@htw-berlin.de')
      auth_successful = ldap_adapter
                        .create(ldap_password: 'egal')
                        .authenticate
      expect(auth_successful).to be true
    end
  end
end

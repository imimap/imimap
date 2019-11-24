# frozen_string_literal: true

# require 'ldap/ldap_htw_adapter'
require 'rails_helper'

describe LDAPHTWAdapter, type: :feature do
  context 'with configuration' do
    before(:each) do
      LDAPHTWAdapter.substitute_netldap(mock: nil)
      @ldap_adapter = LDAPHTWAdapter.new(email: 'email@htw-berlin.de')
                                    .create(ldap_password: 'egal')
    end
    context '- real' do
      it 'is valid' do
        expect(@ldap_adapter.valid).to be_truthy
      end
      it 'does not authenticate' do
        auth_successful = @ldap_adapter.authenticate
        expect(auth_successful).to be false
      end
    end
    context '- mock' do
      before(:each) do
        allow_ldap_login(success: true)
      end
      it 'is valid' do
        expect(@ldap_adapter.valid).to be_truthy
      end
      it 'authenticates' do
        auth_successful = @ldap_adapter.authenticate
        expect(auth_successful).to be true
      end
    end
  end
  context 'with always_return_true' do
    before(:each) do
      @store = ENV['LDAP']
      ENV['LDAP'] = 'ALWAYS_RETURN_TRUE'
      LDAPHTWAdapter.substitute_netldap(mock: nil)
      @ldap_adapter = LDAPHTWAdapter.new(email: 'email@htw-berlin.de')
                                    .create(ldap_password: 'egal')
    end
    after(:each) do
      ENV['LDAP'] = @store
    end
    it 'is valid' do
      expect(@ldap_adapter.valid).to be_truthy
    end
    it 'authenticates' do
      auth_successful = @ldap_adapter.authenticate
      expect(auth_successful).to be true
    end
  end
end

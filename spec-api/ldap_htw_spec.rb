# frozen_string_literal: true

# to run this api test, you need to
# - be within the HTW network to be able to connect to LDAP
# - set three environment variables:
# LDAP
# EMAIL
# PASSWORD
# e.g.

# $ export LDAP='<host>|<port>|<connectstring>'
# $ export EMAIL='kleinen@htw-berlin.de'
# $ export HISTCONTROL=ignorespace
# $  export PASSWORD=<yourvalidpassword>

# by setting the HISTCONTROL=ignorespace and prefixing the export PASSWORD with
# a space the password should not show up in your shell history.
require_relative './../spec/rails_helper'
require 'ldap/ldap_htw_adapter'

describe LDAPHTWAdapter do
  before :each do
    @email = ENV['EMAIL']
    @password = ENV['PASSWORD']
    @ldap_adapter = LDAPHTWAdapter.new(email: @email)
  end
  describe 'ENV needs to be present: ' do
    it 'these API access tests only work if LDAP config present' do
      expect(ENV['LDAP']).not_to be_nil
    end
    it 'EMAIL' do
      expect(@email).not_to be_nil
    end
    it 'PASSWORD' do
      expect(@password).not_to be_nil
    end
  end

  describe 'successful login' do
    it 'ldap adapter is valid' do
      expect(@ldap_adapter.valid?).to be_truthy
      expect(@ldap_adapter).to be_valid
    end
    it 'authenticates' do
      expect(@ldap_adapter.create(ldap_password: @password).authenticate).to(
        be true
      )
    end
  end

  describe 'LDAPHTWAdapter errors' do
    it 'wrong password' do
      authenticated = @ldap_adapter.create(ldap_password: 'notpw').authenticate
      expect(authenticated).to be false
    end

    it 'empty password' do
      authenticated = @ldap_adapter.create(ldap_password: '').authenticate
      expect(authenticated).to be false
    end

    it 'LDAP env missing' do
      restore = ENV['LDAP']
      ENV['LDAP'] = nil
      authenticated = @ldap_adapter
                      .create(ldap_password: @password)
                      .authenticate
      expect(authenticated).to be false
      # expect(ldap_adapter.errors).not_to be_empty
      # expect(ldap_adapter.errors).to include([:ldap_env_missing, ''])
      ENV['LDAP'] = restore
    end

    it 'host unreachable' do
      restore = ENV['LDAP']
      ENV['LDAP'] = "xx#{ENV['LDAP']}"
      _host, _port, _connectstring = @ldap_adapter.config
      authenticated = @ldap_adapter.create(ldap_password: @password)
                                   .authenticate
      expect(authenticated).to be false
      # expect(ldap_adapter.errors).not_to be_empty
      # expect(ldap_adapter.errors).to include([:ldap_could_not_connect, host])
      ENV['LDAP'] = restore
    end
  end

  describe 'LDAPHTWAdapter errors' do
    it 'valid email' do
      adapter = LDAPHTWAdapter.new(email: 'amy@nothtw-berlin.de')
      expect(adapter).to be_valid
    end

    it 'wrong email' do
      wrong_email = 'amy@xxx-berlin.de'
      adapter = LDAPHTWAdapter.new(email: wrong_email)
      expect(adapter).not_to be_valid
      # expect(adapter.errors).not_to be_empty
      # expect(adapter.errors).to include([:ldap_email_not_valid, wrong_email])
    end
  end
end

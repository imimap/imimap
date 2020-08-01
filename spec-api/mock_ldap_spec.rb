# frozen_string_literal: true

require_relative './../spec/rails_helper'

describe 'mock ldap' do
  it 'this spec needs LDAP environment variable to be set' do
    expect(ENV['LDAP']).not_to be_nil
    # LDAP='ldaphost.htw-berlin.de|636|DC=htw-berlin,DC=de'
  end

  it 'always returns true' do
    # this happens somewhere down in the devise strategy and
    # cannot be altered from the test
    adapter = LDAPHTWAdapter.new(email: 'kleinen@htw-berlin.de')

    # this needs to be done before test cases that use
    # ldap
    ldap_mock = instance_double('Net::LDAP')
    LDAPHTWAdapter.substitute_netldap(mock: ldap_mock)

    expect(adapter.valid?).to be_truthy

    allow(ldap_mock).to receive(:bind).and_return(true)

    expect(adapter.authenticate).to be true
  end
end

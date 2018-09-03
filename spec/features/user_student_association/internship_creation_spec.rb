# frozen_string_literal: true

require 'rails_helper'

describe 'Internship creation and editing:' do
  before(:each) do
    @ldap_mock = ldap_mock = instance_double('Net::LDAP')
    LDAPHTWAdapter.substitute_netldap(mock: ldap_mock)
    allow(ldap_mock).to receive(:bind).and_return(true)
  end

end

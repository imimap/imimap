require 'rails_helper'

RSpec.describe LdapAuthentication, :type => :model do
  let(:ldap_authentication) {
    LdapAuthentication.new("username", "password")
  }

  it 'should create a new instance' do
    expect(ldap_authentication).to be_truthy
  end

  describe "#authorized?"  do
    it 'should be authorized' do
      expect(ldap_authentication.authorized?).to eq true
    end
  end
end

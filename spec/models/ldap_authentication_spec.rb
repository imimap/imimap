require 'rails_helper'

RSpec.describe LdapAuthentication, :type => :model do

  describe "#authorized?"  do
    it 'should be authorized' do
      expect(LdapAuthentication.authorized?("user","password")).to eq true
    end
  end
end

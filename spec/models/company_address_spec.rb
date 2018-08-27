# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CompanyAddress, type: :model do
  before :each do
    @company = create :company
    @company_address = @company.company_addresses.first
  end
  describe '#one_line' do
    it 'builds the expected address string' do
      expect(@company_address.one_line).to(
        eq [@company_address.street,
            @company_address.zip,
            @company_address.city,
            @company_address.country].join(', ')
      )
    end
  end
end

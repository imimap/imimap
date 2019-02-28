# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CompleteInternshipDataHelper, type: :helper do
  before :each do
    @internship = create :internship_1
  end
  describe 'internship_state' do
    it 'lists the individual states' do
      ci = CompleteInternshipDataHelper::CompleteInternshipData
           .from(@internship)
      expected = 'Contract: contract state name; '
      expected += 'Registration: registration state name; '
      expected += 'Certificate: certificate state name'
      expect(ci.internship_state).to eq(expected)
    end
  end
end

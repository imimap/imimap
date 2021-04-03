# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InternshipsDtoHelper, type: :helper do
  before :each do
    @internship = create :internship01
  end
  describe 'internship_state' do
    it 'lists the individual states' do
      ci = InternshipsDtoHelper::InternshipsDto
           .from(@internship)
      expected = 'Contract: contract state name; '
      expected += 'Registration: registration state name; '
      expected += 'Certificate: certificate state name'
      expect(ci.internship_state).to eq(expected)
    end
  end
end

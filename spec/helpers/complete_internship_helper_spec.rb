# frozen_string_literal: true

require 'rails_helper'

include CompleteInternshipHelper
RSpec.describe CompleteInternshipHelper, type: :helper do
  context 'with passed internship' do
    before :each do
      @internship = create :internship
    end
    describe 'internship_state' do
      it 'just uses passed' do
        ci = CompleteInternship.from(@internship)
        expect(ci.internship_state).to eq('passed')
      end
    end
  end

  context 'with waiting internship' do
    before :each do
      @internship = create :internship_1
    end
    describe 'internship_state' do
      it 'lists the individual states' do
        ci = CompleteInternship.from(@internship)
        expected = 'Contract: contract state name; '
        expected += 'Registration: registration state name; '
        expected += 'Certificate: certificate state name'
        expect(ci.internship_state).to eq(expected)
      end
    end
  end
  context 'with internship with missing states' do
    before :each do
      @internship = create :internship_without_states
    end
    describe 'internship_state' do
      it "doesn't throw exceptions" do
        ci = CompleteInternship.from(@internship)
        expect(ci.internship_state).to eq('')
      end
    end
  end
end
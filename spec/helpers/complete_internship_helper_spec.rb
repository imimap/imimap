# frozen_string_literal: true

require 'rails_helper'
include CompleteInternshipHelper
RSpec.describe CompleteInternshipHelper, type: :helper do
  before :each do
    @internship = create :internship
  end

  describe '#add_student_info' do
    it 'should store information of student in variables' do
      #  expect(helper.add_student_info(@internship)).to eql('(no student)')
    end
  end

  describe '#add_company_info' do
  end

  describe '#add_status_info' do
    it 'should work even if status is nil' do
      ci = CompleteInternship.from(@internship)
      expect(ci.internship_state).to eq('Contract: contract state name; Registration: registration state name; Certificate: certificate state name')
    end
  end

  describe '#CompleteInternship.from' do
  end
end

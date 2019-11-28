# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InternshipsDtoHelper, type: :helper do
  context 'with passed internship' do
    before :each do
      @internship = create :internship
    end
    describe 'internship_state' do
      it 'just uses passed' do
        ci = InternshipsDtoHelper::InternshipsDto
             .from(@internship)
        expect(ci.internship_state).to eq('passed')
      end
    end
  end

  context 'with internship with missing states' do
    before :each do
      @internship = create :internship_without_states
    end
    describe 'internship_state' do
      it "doesn't throw exceptions" do
        ci = InternshipsDtoHelper::InternshipsDto
             .from(@internship)
        expect(ci.internship_state).to eq('')
      end
    end
  end
end

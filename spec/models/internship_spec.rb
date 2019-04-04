# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Internship, type: :model do
  let(:internship) { create :internship }
  let(:internship_saved) { create :internship }
  context 'given a valid Internship' do
    it 'can be saved with all required attributes present' do
      # FactoryBot 5 factories now inherit their parent's create strategy
      # https://www.rubydoc.info/gems/factory_bot/file/GETTING_STARTED.md
      # had to simplify this test:
      expect(internship.errors.messages).to be_empty
    end
    it 'has a complete model' do
      expect(internship.student).not_to be_nil
    end
  end

  context 'given an invalid Internship' do
    it 'rejects empty semester_ids' do
      internship.semester_id = nil
      expect(internship.save).to be_falsy
    end

    it 'rejects empty complete_internship_id' do
      internship.complete_internship_id = nil
      expect(internship.save).to be_falsy
    end
  end

  describe '#rating' do
    it 'returns the correct rating' do
      expect(internship.rating).to eq(3)
    end
  end

  describe '#editable?' do
    it 'should return true' do
      expect(internship.editable?).to eq(true)
    end

    it 'should return false' do
      internship.completed = true
      expect(internship.editable?).to eq(false)
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build :user }

  context 'given a valid user' do
    it 'can be saved with all required attributes present' do
      expect(user.save).to be_truthy
    end
  end

  context 'given an invalid user' do
    it 'rejects empty emails' do
      user.email = nil
      expect(user.save).to be_falsy
    end

    it 'rejects empty passwords' do
      user.password = nil
      expect(user.save).to be_falsy
    end

    it 'rejects passwords shorter than 5 characters' do
      user.password = 'asdf'
      expect(user.save).to be_falsy
    end
  end

  describe '#name' do
    it 'should return the correct name' do
      expect(user.name)
        .to eq "#{user.student.first_name} #{user.student.last_name}"
    end
  end

  describe '#enrolment_number' do
    it 'should return enrolment_number from email if no student present' do
      user.student = nil
      matrikel = User.enrolment_number_from(email: user.email)
      expect(user.enrolment_number).to eq matrikel
    end
    it 'should return nil it cannot be determined' do
      user.student = nil
      user.email = 'not.a@student.de'
      expect(user.enrolment_number).to eq nil
    end
    it 'should return the correct enrolment_number' do
      expect(user.enrolment_number).to eq user.student.enrolment_number
    end
  end

  describe 'feature toggles can be set' do
    before :each do
      @features = %i[a b c]
      @features.each do |feature|
        FT.for(feature) do |_current_user|
          true
        end
      end
    end
    it 'with array' do
      user.feature_toggles = @features
      expect(user.feature_toggles).to eq @features
      user.save
      user.reload
      expect(user.feature_toggles).to eq @features
    end
    it 'with string' do
      user.feature_toggles = 'a, b, c'
      user.save
      user.reload
      expect(user.feature_toggles).to eq @features
    end
  end
end

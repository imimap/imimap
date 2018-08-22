# frozen_string_literal: true

require 'rails_helper'

describe 'Detect if a User is a Student' do
  context 'factory' do
    it 'creates one student' do
      expect { create(:student_user) }.to change { Student.count }.by(1)
    end
    it 'creates one user' do
      expect { create(:student_user) }.to change { User.count }.by(1)
    end
  end
  context 'with student user' do
    before :each do
      @user = create(:student_user)
    end

    it 'is determined by the email address' do
      expect(@user.student?).to be true
    end
  end

  context 'with prof user' do
    before :each do
      @user = create(:prof)
    end

    it 'is determined by the email address' do
      expect(@user.student?).to be false
    end
  end

  context 'with admin user' do
    before :each do
      @user = create(:admin)
    end

    it 'is determined by the email address' do
      expect(@user.student?).to be false
    end
  end
end

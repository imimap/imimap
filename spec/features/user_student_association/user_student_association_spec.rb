# frozen_string_literal: true

require 'rails_helper'

describe 'Student login:' do
  before(:each) do
    allow_ldap_login
  end

  context 'first time - no user present' do
    it 'user is created' do
      expect do
        sign_in_with(enrolment_number: '54321')
      end.to change { User.count }.by(1)
    end

    it 'created user is associated with existing student object' do
      enrolment_number = '12121'
      student = create(:student, enrolment_number: enrolment_number)
      sign_in_with(enrolment_number: enrolment_number)
      user = User.last
      expect(user.email).to eq User.email_for(enrolment_number: enrolment_number)
      expect(user.student).to eq student
    end
    it 'student object is created if not present' do
      enrolment_number = '47112'
      expect do
        sign_in_with(enrolment_number: enrolment_number)
      end.to change { Student.count }.by(1)
      student = Student.last
      user = User.last
      expect(user.email).to eq User.email_for(enrolment_number: enrolment_number)
      expect(user.student).to eq student
    end
  end

  context 'second time - user & student already present' do
    before :each do
      @enrolment_number = '14123'
      @email = User.email_for(enrolment_number: @enrolment_number)
      @student = create(:student, enrolment_number: @enrolment_number)
      @user = create(:user, email: @email)
    end
    it 'logs in and no student is created' do
      expect do
        sign_in_with(enrolment_number: @enrolment_number)
      end.to change { Student.count }.by(0)
    end
    it 'logs in and no user is created' do
      expect do
        sign_in_with(enrolment_number: @enrolment_number)
      end.to change { User.count }.by(0)
    end
  end

  context 'existing user with missing student object' do
    before :each do
      @enrolment_number = '14123'
      @email = User.email_for(enrolment_number: @enrolment_number)
      @user = create(:user_without_student, email: @email)
    end
    it 'logs in and no user is created' do
      expect do
        sign_in_with(enrolment_number: @enrolment_number)
      end.to change { User.count }.by(0)
    end

    it 'logs in and student is created' do
      expect do
        sign_in_with(enrolment_number: @enrolment_number)
      end.to change { Student.count }.by(1)
    end
    it 'student is associated with user' do
      sign_in_with(enrolment_number: @enrolment_number)
      user = User.where(email: @email).first
      expect(user.student.email).to eq @email
    end
  end
end

describe 'Non-Student login:' do
  before(:each) do
    allow_ldap_login
  end

  context 'first time - no user present' do
    it 'user is created but no student object' do
      expect do
      expect{sign_in_with_mail(email: 'testperson@htw-berlin.de')}.to change{User.count}.by(1)
      end.to change { Student.count }.by(0)
    end
  end

  context 'second time - user already present' do
    before :each do
      @user = create(:user_without_student, email: 'testperson@htw-berlin.de')
    end
    it 'logs in and no student and user is created' do
      expect do
        expect{sign_in_with_mail(email: 'testperson@htw-berlin.de')}.to change{Student.count}.by(0)
      end.to change { User.count }.by(0)
    end
  end
end

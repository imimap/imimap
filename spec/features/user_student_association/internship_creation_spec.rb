# frozen_string_literal: true

require 'rails_helper'

def sign_in_with(enrolment_number:)
  visit root_path
  fill_in 'user_email', with: "s#{enrolment_number}@htw-berlin.de"
  fill_in 'user_password', with: 'geheim'
  click_on I18n.t('devise.sessions.submit')
  expect(page).to have_content t('devise.sessions.signed_in')
end

describe 'Internship creation and editing' do
  before (:each) do
    @ldap_mock = ldap_mock = instance_double('Net::LDAP')
    LDAPHTWAdapter.substitute_netldap(mock: ldap_mock)
    allow(ldap_mock).to receive(:bind).and_return(true)
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
      expect(user.email).to eq "s#{enrolment_number}@htw-berlin.de"
      expect(user.student).to eq student
    end
    it 'student object is created if not present' do
      enrolment_number = '47112'
      expect do
        sign_in_with(enrolment_number: enrolment_number)
      end.to change { Student.count }.by(1)
      student = Student.last
      user = User.last
      expect(user.email).to eq "s#{enrolment_number}@htw-berlin.de"
      expect(user.student).to eq student
    end
  end

  context 'second time - user already present' do
    before :each do
    end
    it 'logs in and student info can be shown'
  end
end

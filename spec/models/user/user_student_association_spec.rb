# frozen_string_literal: true

require 'rails_helper'

describe 'user student association ' do
  context 'basics' do
    it 'regexp' do
      email = 's0575757@htw-berlin.de'
      match = User::STUDENT_MAIL_REGEX.match(email)
      expect(match).not_to be_nil
    end
    it 'enrolment_number_from' do
      email = 's0567123@htw-berlin.de'
      er = '567123'
      expect(User.enrolment_number_from(email: email)).to eq er
    end

    it 'email_for' do
      email = 's0556677@htw-berlin.de'
      er = '556677'
      expect(User.email_for(enrolment_number: er)).to eq email
    end
  end
  context 'creation' do
    it 'finds user, creates student' do
      user = create(:student_user_without_student)
      user2 = User.find_or_create(email: user.email,
                                  password: 'new_password')
      expect(user2.student).not_to be_nil
    end
  end
end

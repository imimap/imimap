# frozen_string_literal: true

require 'rails_helper'
require 'cancan/matchers'

describe 'User Role' do
  describe 'abilities' do
    subject(:ability) { Ability.new(user) }
    let(:user) { nil }

    context 'when is a regular user' do
      let(:user) { create(:user) }

      it { is_expected.not_to be_able_to(:read, Internship.new) }
      it { is_expected.to be_able_to(:create, Internship) }

    end
    context 'when is a regular user with own internship' do
      before :each do
        student = create(:student2)
        @own_internship = create(:internship, student: student)
        @user = create(:user, student: student)
      end
      let(:user) { @user }

      it 'assigns the right things' do
        expect(@own_internship.student.user).to eq @user
      end
      it { is_expected.to be_able_to(:read, @own_internship) }



    end
  end
end

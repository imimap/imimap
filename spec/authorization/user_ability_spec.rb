# frozen_string_literal: true

require 'rails_helper'
require 'cancan/matchers'

# This is just a start created quickly from the
# example in the cancancan documentation.
# Not sure if this is the way to go, though;
# probably it is only useful for more complicated
# cases as with conditions over associations;
# probably better to create feature tests for
# crucial things like no one getting
# access to internships#index
describe 'User Role' do
  describe 'abilities' do
    subject(:ability) { Ability.new(user) }
    let(:user) { nil }

    context 'when is a regular user' do
      let(:user) { create(:user) }
      it { is_expected.not_to be_able_to(:index, Internship) }
      it { is_expected.not_to be_able_to(:list, Internship) }
      it { is_expected.not_to be_able_to(:show, Internship.new) }
      it { is_expected.to be_able_to(:create, Internship) }
    end
    context 'when is a regular user with own internship' do
      # TBD: replace this with a factory creating user with student with
      # internship and just have an elegant let here
      before :each do
        student = create(:student2)
        @own_internship = create(:internship, student: student)
        @user = create(:user, student: student)
      end
      let(:user) { @user }

      it 'assigns the right things' do
        expect(@own_internship.student.user).to eq @user
      end
      it { is_expected.to be_able_to(:show, @own_internship) }
    end
  end
end

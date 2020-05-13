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
    subject(:ability) do
      @ci = create(:complete_internship)
      @user = @ci.student.user
      Ability.new(@user)
    end

    context 'when is a regular user' do
      before :each do
        @complete_internship = create(:complete_internship)
        @user = @complete_internship.student.user
      end
      it { is_expected.not_to be_able_to(:index, CompleteInternship) }
      it { is_expected.not_to be_able_to(:list, CompleteInternship) }
      it { is_expected.not_to be_able_to(:show, @complete_internship) }
      it { is_expected.to be_able_to(:create, CompleteInternship) }
    end
  end
end

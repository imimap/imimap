# frozen_string_literal: true

require 'rails_helper'
require_relative './checklist_helper.rb'
describe 'Internship Creation' do
  include CompleteInternshipCheckListHelper
  context 'without internship' do
    before :each do
      @user = login_with(user_factory: :user)
      create_complete_internship
      create_internship
      visit my_internship_path_replacement
    end
    it { expect_to_be_on_my_internship_page }
  end
end

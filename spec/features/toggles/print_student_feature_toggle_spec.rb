# frozen_string_literal: true

require 'rails_helper'

describe 'toggle student_can_print_internship_application:
        complete_internships.checklist.print_form is shown for factory users' do
  def create_internship
    create(:semester)
    visit my_internship_path
    click_link(t('internships.provide_now'))
    click_on t('save')
    click_on t('complete_internships.new_tp0')
    click_on t('save')
  end

  def expect_feature(available: true)
    create_internship
    expect(page.has_content?(t(
                               'complete_internships.checklist.print_form'
                             ), count: 2)).to be(available)
  end

  context 'factory users:' do
    before :each do
      @user = create(:user)
      sign_in(@user)
    end
    it 'feature is available' do
      expect_feature(available: true)
    end
  end

  context 'user with s05... addresses' do
    before :each do
      @user = create(:user_for_s05, email: 's051234@htw-berlin.de')
      sign_in(@user)
    end
    it 'dont see the feature' do
      expect_feature(available: false)
    end
    it 'see the feature if configured' do
      @user.feature_toggles = [:student_can_print_internship_application]
      @user.save
      expect_feature(available: true)
    end
  end
end

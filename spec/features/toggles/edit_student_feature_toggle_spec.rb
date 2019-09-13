# frozen_string_literal: true

require 'rails_helper'

describe 'toggle student_can_edit_internship:' do
  def expect_feature(available: true)
    visit root_path
    expect(page.has_content?(t('header.internship'))).to be(available)
  end
  it 'header.internship is shown for factory users' do
    @user = create(:user)
    sign_in(@user)
    expect_feature(available: true)
  end

  it 'header.internship is shown for s05 users with config' do
    @user = create(:user,
                   email: 's051234@htw-berlin.de',
                   feature_toggles: [:student_can_edit_internship])
    sign_in(@user)
    expect_feature(available: true)
  end

  context 'user with s05... addresses' do
    before :each do
      @user = create(:user, email: 's051234@htw-berlin.de')
      sign_in(@user)
    end
    it 'dont see the feature' do
      expect_feature(available: false)
    end
  end
end

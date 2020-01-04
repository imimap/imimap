# frozen_string_literal: true

require 'rails_helper'
describe 'Internship Creation' do
  def expect_to_be_on_my_internship_page
    expect(page).to have_content(@user.name)
    expect(page).to have_content(t('complete_internships.semester')
                                     .strip)
  end

  def create_complete_internship
    visit my_internship_path_replacement
    expect(page).to have_content('Praktikumsdetails')
    click_link(t('internships.provide_now'))
    click_on t('save')
    expect(page).to have_content(@user.name)
  end

  def create_internship
    create(:semester)
    visit my_internship_path_replacement
    click_on t('complete_internships.new_tp0')
    expect(page).to have_field('Semester')
    click_on t('save')
  end
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

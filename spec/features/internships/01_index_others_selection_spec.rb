# frozen_string_literal: true

require 'rails_helper'

describe 'internship - index selection' do
  before :each do
    @user = create(:admin)
    sign_in(@user)
    @semester1 = Semester.for_date('2015-05-08')
    @semester2 = Semester.for_date('2016-11-08')
    @internship1 = create(:internship_1, semester: @semester1)
    @internship2 = create(:internship_2, semester: @semester2)
  end

  it 'current semester is empty' do
    visit internships_path
    [@internship1, @internship2].each do |internship|
      expect(page).not_to have_content(internship.start_date)
      expect(page).not_to have_content(internship.company_address.country_name)
      expect(page).not_to have_content(internship.internship_state.name)
    end
  end
  it 'semester can be selected' do
    visit internships_path
    select @semester2.name, from: 'semester_select'
    click_on t('internships.index.select')
    expect(page).to have_content(@internship2.start_date)
    expect(page).to have_content(@internship2.company_address.country_name)
    expect(page).to have_content(@internship2.internship_state.name)
    expect(page).not_to have_content(@internship1.company_address.country_name)
  end
end

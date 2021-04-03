# frozen_string_literal: true

require 'rails_helper'

describe 'internship - index selection' do
  before :each do
    @user = create(:admin)
    sign_in(@user)
    @semester1 = Semester.for_date('2015-05-08')
    @semester2 = Semester.for_date('2016-11-08')

    @registration_state1 = create(:registration_state, name: 'accepted')
    @registration_state2 = create(:registration_state, name: 'in examination office')

    @internship_state1 = create(:internship_state, name: 'passed')
    @internship_state2 = create(:internship_state, name: 'the student still has to pass the following courses')

    @internship1 = create(:internship_1, semester: @semester1, registration_state: @registration_state1,
                                         internship_state: @internship_state1)
    @internship2 = create(:internship_2, semester: @semester2, registration_state: @registration_state2,
                                         internship_state: @internship_state2)
  end

  it 'current semester is empty' do
    visit internships_path
    [@internship1, @internship2].each do |internship|
      expect(page).not_to have_content(internship.start_date)
      expect(page).not_to have_content(internship.company_address.country_name)
      # expect(page).to have_content(task.title, count: 1)
      expect(page).to have_content(internship.internship_state.name, count: 1)
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
  it 'internship state can be selected' do
    visit internships_path
    select @semester2.name, from: 'semester_select'
    select @internship_state2.name, from: 'internship_state_select'
    click_on t('internships.index.select')
    expect(page).to have_content(@internship2.start_date)
    expect(page).to have_content(@internship2.company_address.country_name)
    expect(page).to have_content(@internship2.internship_state.name)
    expect(page).not_to have_content(@internship1.company_address.country_name)
  end
  it 'registration state can be selected' do
    visit internships_path
    select @semester2.name, from: 'semester_select'
    select @registration_state2.name, from: 'registration_state_select'
    click_on t('internships.index.select')
    expect(page).to have_content(@internship2.start_date)
    expect(page).to have_content(@internship2.company_address.country_name)
    expect(page).to have_content(@internship2.internship_state.name)
    expect(page).not_to have_content(@internship1.company_address.country_name)
  end
  it 'bad search query should yield no results' do
    visit internships_path
    select @semester2.name, from: 'semester_select'
    select @internship_state1.name, from: 'internship_state_select'
    select @registration_state2.name, from: 'registration_state_select'
    click_on t('internships.index.select')
    expect(page).not_to have_content(@internship2.company_address.country_name)
    expect(page).not_to have_content(@internship1.company_address.country_name)
  end
end

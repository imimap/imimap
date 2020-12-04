# frozen_string_literal: true

require 'rails_helper'

describe 'internship postponement' do
  before :each do
    @student = create(:student2)
    @user = @student.user
    sign_in(@user)
    Semester.current.save
    Semester.current.next.save
  end
  it 'create postponement application and ci' do
    # include ApplicationHelper
    # visit path_to_complete_internship
    # visit no_complete_internship_path
    # click_on t('internships.provide_now')

    visit my_internship_path_replacement
    click_button(t('internships.provide_now'))
    click_link(t('consent.ok_cool'))
    click_on t('save')

    click_on t('postponements.new')
    select(Semester.current.next.name, from: :postponement_semester_id)
    fill_in :postponement_semester_of_study, with: '5'
    fill_in :postponement_reasons, with: 'this and that'
    click_on t('postponements.application.send')
    postponement = @student.postponements.last
    expect(postponement).not_to be_nil
    expect(postponement.semester.name).to eq(Semester.current.next.name)
    expect(postponement.reasons).to eq 'this and that'
    expect(postponement.semester_of_study).to eq 5
  end
  it 'create postponement application wthout ci' do
    # include ApplicationHelper
    # visit path_to_complete_internship
    # visit no_complete_internship_path
    # click_on t('internships.provide_now')

    visit my_internship_path_replacement

    click_on t('postponements.new')
    select(Semester.current.next.name, from: :postponement_semester_id)
    fill_in :postponement_semester_of_study, with: '5'
    fill_in :postponement_reasons, with: 'this and that'
    click_on t('postponements.application.send')
    postponement = @student.postponements.last
    expect(postponement).not_to be_nil
    expect(postponement.semester.name).to eq(Semester.current.next.name)
    expect(postponement.reasons).to eq 'this and that'
    expect(postponement.semester_of_study).to eq 5
  end
end

# frozen_string_literal: true

require 'rails_helper'

describe 'internship postponement' do
  before :each do
    @user = create(:admin)
    sign_in(@user)
    Semester.current.save
    Semester.current.next.save
    @postponement = create(:postponement_unapproved)
  end
  it 'shows the postponements in the index' do
    visit postponements_path
    expect(page).to have_content(@postponement.semester.name)
  end
  it 'shows one postponement' do
    visit postponements_path
    click_on t('postponements.show')
    expect(page).to have_content(@postponement.semester.id)
    expect(page).to have_content(@postponement.semester.name)
  end
  it 'destroys one postponement' do
    visit postponements_path
    expect(page).to have_content(@postponement.semester.name)
    expect do
      click_on t('postponements.destroy')
    end.to change(Postponement, :count).by(-1)
    expect(page).not_to have_content(@postponement.semester.name)
  end
  it 'approves one postponement' do
    visit postponements_path
    expect(page).not_to have_content(@user.email)
    click_on t('postponements.approve')
    expect(page).to have_content(@user.email)
    expect(page).to have_content(@postponement.approved_at)
  end
end

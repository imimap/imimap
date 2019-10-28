# frozen_string_literal: true

require 'rails_helper'

describe 'Ability: Student edits Internship' do
  context 'not approved' do
    before :each do
      @internship = create(:internship)
      @complete_internship = @internship.complete_internship
      @user = @internship.complete_internship.student.user
      sign_in @user
      visit my_internship_path
    end
    it ' shows edit link' do
      expect(page).to have_link(t('buttons.edit'), href:
      edit_complete_internship_path(id: @complete_internship.id,
                                    locale: I18n.locale))
    end
    it 'shows personal details edit link' do
      expect(page).to have_link(
        t('complete_internships.checklist.personal_details'), href:
      edit_complete_internship_path(id: @complete_internship.student.id,
                                    locale: I18n.locale))
    end

    it 'shows company details edit link' do
      expect(page).to have_link(
        t('complete_internships.checklist.company_details'), href:
    edit_company_path(id: @internship.company_address.company,
                      internship_id: @internship.id,
                      locale: I18n.locale))
    end
    it 'shows internship details as link' do
      expect(page).to have_link(
        t('complete_internships.checklist.internship_details'), href:
      edit_internship_path(id: @internship.id,
                           locale: I18n.locale))
    end
    it 'shows contract radio buttons'
  end
  context 'approved' do
    before :each do
      @internship = create(:internship, approved: true)
      @complete_internship = @internship.complete_internship
      @user = @internship.complete_internship.student.user
      sign_in @user
    end
    it ' shows link' do
      visit my_internship_path
      expect(page).not_to have_link(t('buttons.edit'), href:
      edit_complete_internship_path(id: @complete_internship.id,
                                    locale: I18n.locale))
    end
  end
end

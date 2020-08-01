# frozen_string_literal: true

require 'rails_helper'

describe 'Ability: Student edits Internship' do
  include CompleteInternshipsChecklistPageflow
  context 'not approved' do
    it 'ensure factories are working as expecting' do
      # this needs to work in order to assume the right associations used in
      # the views by the tests below
      expect { create(:internship_not_approved) }.to change {
                                                       CompleteInternship.count
                                                     }.by(1)
      expect { create(:internship_not_approved) }.to change {
                                                       Company.count
                                                     }.by(1)
      expect { create(:internship_not_approved) }.to change {
                                                       CompanyAddress.count
                                                     }.by(1)
    end
    before :each do
      @internship = create(:internship_not_approved)
      @complete_internship = @internship.complete_internship
      @user = @internship.complete_internship.student.user
      sign_in @user
      visit my_internship_path_replacement
    end
    it 'should have complete model' do
      ability = Ability.new(@user)
      expect(ability.can?(:edit, @internship)).to be true
      expect(ability.can?(:edit, @complete_internship)).to be true
      expect(@complete_internship.student.internships.size).to eq 1
    end
    it ' shows edit link' do
      expect(page).to have_link(t('buttons.edit'), href:
      edit_complete_internship_path(id: @complete_internship.id,
                                    locale: I18n.locale))
    end
    it 'shows personal details edit link' do
      expect(page).to have_link(
        t('complete_internships.checklist.personal_details'), href:
      student_path(id: @complete_internship.student.id,
                   locale: I18n.locale, cidcontext: @complete_internship.id)
      )
    end

    it 'shows company details edit link' do
      expect(page).to have_link(
        t('complete_internships.checklist.company_details'), href:
    edit_company_path(id: @internship.company_address.company,
                      internship_id: @internship.id,
                      locale: I18n.locale,
                      cidcontext: @complete_internship.id)
      )
    end
    it 'shows internship details as link' do
      expect(page).to have_link(
        href: edit_internship_path(
          id: @internship,
          cidcontext: @complete_internship.id,
          locale: I18n.locale
        )
      )
    end
    it 'shows contract version' do
      expect(page).to have_text(
        t('complete_internships.checklist.contract_original')
      )
      expect(page).not_to have_text(
        t('complete_internships.checklist.contract_copy')
      )
    end
  end
  context 'approved' do
    before :each do
      @internship = create(:internship)
      @complete_internship = @internship.complete_internship
      @user = @internship.complete_internship.student.user
      sign_in @user
    end
    it ' shows link' do
      visit my_internship_path_replacement
      expect(page).not_to have_link(t('buttons.edit'), href:
      edit_complete_internship_path(id: @complete_internship.id,
                                    locale: I18n.locale))
    end
  end
end
